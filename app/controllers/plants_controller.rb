class PlantsController < ApplicationController
  rescue_from 'ActionController::UnpermittedParameters' do |exception|
    render json: { error: true, message: exception }, status: :unprocessable_entity
  end

  def index
    render json: ::CachedPlantSearch.new(search_params)
  end

  def show
    render json: ::CachedPlantSearch.new(id: params[:id])
  end

  private

  def search_params
    params.permit(:page, filter: {}, filter_not: {}, order: {})
  end
end
