class MoviesController < ApplicationController
  def index
    raise ActionController::BadRequest.new, "query query_param is missing" if params[:query].nil?

    result = TMDB::APIClient.search_movie(search_movie_params.to_h)

    render json: { "data": result[:data] }, status: :ok
  end

  private

  def search_movie_params
    params.permit(:query, :include_adult, :language, :primary_release_year, :page, :region, :year)
  end
end
