require_relative "../services/tmdb.rb"

class SearchesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    set_instance_vars
  end

  def create
    query = params[:queries].present? ? "#{params[:queries]}&#{params[:search][:query]}" : params[:search][:query]
    @search = Search.new(query: query)
    @search.user = current_user if user_signed_in?
    if @search.save
      redirect_to root_path(construct_query)
    else
      render :home
    end
  end

  def get_actors
    # just left here for test prposes, not really used
    tmdb = Tmdb.new(ENV["TMDB_KEY"])
    @result = tmdb.get_actors(params[:movie_id])
    render json: result
  end

  private

  def construct_query
    if params[:search][:photo]
      search_params
    else
      previous_queries = params[:queries].present? ? "#{params[:queries]}&" : ""
      { search: { queries: previous_queries + params[:search][:query] } }
    end
  end

  def user_params
    params.except(:controller, :action)
  end

  def set_instance_vars
    user_params.empty? || user_params[:photo] ? no_params : set_vars_from_params
    @search = Search.new
  end

  def no_params
    @query = []
    @results = []
  end

  def set_vars_from_params
    @query = user_params[:search][:queries].strip.split("&")
    # @query [ "123" ] is an array stores the ids we need to use to call the api
    # @results = search_results(params[:search][:queries])
    tmdb = Tmdb.new(ENV["TMDB_KEY"])
    @results = tmdb.get_actors_and_movie(@query.last.to_i)
  end

  def full_query
    user_params
      .as_json
      .map { |key, _value| params[key] }
      .join("&")
  end

  def search_results(query)
    search = Search.find_by(query: query) || Search.create(query: query)
    JSON.parse(search.result.json)
  end

  def search_params
    params.require(:search).permit(:query, :photo)
  end
end
