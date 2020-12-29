class PlantsController < ApplicationController
  def index
    render json: Search.last(3)
  end
end
