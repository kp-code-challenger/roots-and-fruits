class TrefleRequest
  include HTTParty
  base_uri ENV.fetch('TREFLE_URL', 'https://trefle.io/api/v1')
  # debug_output $stdout

  attr_reader :path, :query

  def initialize(path, query)
    @path = path
    @query = query
  end

  def perform
    self.class.get(path, query: query.merge(token: api_token))
  end

  private

  def api_token
    ENV.fetch('TREFLE_TOKEN')
  end
end
