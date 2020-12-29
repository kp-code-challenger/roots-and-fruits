class SearchesController < ApplicationController
  def index
    @searches = Search.all

    render json: @searches
  end
end
