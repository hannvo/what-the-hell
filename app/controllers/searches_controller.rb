require_relative "../services/tmdb.rb"

class SearchesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    user_params[:photo] ? photo_upload_handler : set_instance_vars
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

  private

  def photo_upload_handler
    # for now, pretend any submitted image is Julia Roberts and
    # redirect to the result page for that search
    @search = Search.new(query: "Julia Roberts")
    @search.save ? (redirect_to result_path(@search.result)) : (redirect_to root_path)
  end

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
    user_params.empty? ? no_params : set_vars_from_params
    @search = Search.new
  end

  def no_params
    @query = []
    @results = []
  end

  def set_vars_from_params
    # @query [ "123", "1231", "123" ] is an array that stores the ids we need to use to call the api
    @query = user_params[:search][:queries].strip.split("&")
    if @query.count > 1 && (actor_ids = Tmdb.matching_cast(@query))
      if actor_ids.count == 1
        # if we have 2 movie inputs and one matching actor
        redirect_to result_path(Result.create(json: actor_ids.first))
      elsif actor_ids.count > 1
        # if we have 2 movie inputs and several matching actors they
        # will be displayed on the preresults page
        cast = []
        actor_ids.each do |actor_id|
          cast << Result.create(json: Tmdb.get_actor_details(actor_id))
        end
        movies = Tmdb.get_movie_details(@query)
        @results = { cast: cast, movies: movies }
      else
        cast = Tmdb.get_actors(@query.last.to_i)
        movies = Tmdb.get_movie_details(@query)
        @results = { cast: cast, movies: movies }
      end

    else
      # if there is only 1 movie input or no matching actors display preresults page
      cast = Tmdb.get_actors(@query.last.to_i)
      movies = Tmdb.get_movie_details(@query)
      @results = { cast: cast, movies: movies }
    end
    # @results = search_results(params[:search][:queries])
  end

  def full_query
    user_params
      .as_json
      .map { |key, _value| params[key] }
      .join("&")
  end

  def search_results(query)
    search = Search.create(query: query)
    JSON.parse(search.result.json)
  end

  def search_params
    params.require(:search).permit(:query, :photo)
  end
end
