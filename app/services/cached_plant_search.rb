class CachedPlantSearch
  attr_reader :params, :trefle_request, :cached_response

  # mimick httparty response to save us some code
  class CachedResponse
    attr_accessor :body, :code
  end

  def initialize(action_controller_params)
    @params = action_controller_params.to_h
    set_edible_default
    @trefle_request = TrefleRequest.new('/plants', params)
    @cached_response = CachedResponse.new.tap { |c| c.code = 200 }
  end

  def to_json(_)
    perform
    cached_response.body
  end

  def perform
    set_from_existing

    return if cached_response.body.present?

    safe_perform
  end

  protected

  def set_edible_default
    params[:filter] ||= {}
    params[:filter].merge!(edible: true)
  end

  def set_from_existing
    cached_response.body = existing_record&.body
  end

  def existing_record
    @existing_record ||= base_search_query.last
  end

  def base_search_query
    Search
      .order(:created_at)
      .where('created_at > ?', newer_than_time)
      .where(query: ordered_query)
  end

  def ordered_query
    @ordered_query ||= (sorted_hash_params + [page_param]).reject(&:blank?).join('&')
  end

  def sorted_hash_params
    %i[filter filter_not order].map do |param_key|
      { param_key => params.fetch(param_key, {}).to_h.sort.to_h }.to_param
    end
  end

  def page_param
    "page=#{params.fetch(:page, 1)}"
  end

  def newer_than_time
    ENV.fetch('CACHE_TTL', 1.hours).to_i.seconds.ago
  end

  def safe_perform
    response = trefle_request.perform
    cached_response.code = response.code
    cached_response.body = response.body
  rescue HTTParty::ResponseError, HTTParty::Error => e # TODO: probably many other errors to handle here
    Rails.logger.error("Error requesting data from Trefle API: #{e}: #{e.backtrace.join("\n")}")
    cached_response.code = 500
    cached_response.body = { error: true, message: 'Internal server error' }.to_json
  ensure
    persist_search
  end

  def persist_search
    Search.create!(body: cached_response.body, query: ordered_query)
  end
end
