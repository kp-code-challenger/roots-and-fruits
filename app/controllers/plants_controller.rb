class PlantsController < ApplicationController
  def index
    render json: TrefleRequest.new('/plants', filter: { edible: true }).perform
  end
end
