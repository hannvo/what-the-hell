class SearchesController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :check_for_params, only: :new

  def new
  end

  def create
    raise
    @search = Search.new(search_params)
    @result = Result.new
    @search.result = @result
    @search.user = current_user if user_signed_in?
    @search.save ? (redirect_to root_path({ query: @search.query })) : (render :new)
  end

  private

  def check_for_params
    @user_params = params.except(:controller, :action)
    @user_params.empty? ? no_params : set_vars_from_params
    @search = Search.new
  end

  def no_params
    @query = []
    @results = []
  end

  def set_vars_from_params
    full_query = @user_params.as_json.map { |key, _value| params[key] }.join('&')
    @query = full_query.split('&')
    @results = find_or_create_search(full_query)
  end

  def find_or_create_search(query)
    search = Search.find_by(query: query) || Search.create(query: query)
    JSON.parse(search.result.json)
  end

  def search_params
    params.require(:search).permit(:query, :user, :result, :photo)
  end
end
