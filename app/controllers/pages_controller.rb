class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    set_instance_vars
  end

  private

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
    @query = user_params[:search][:queries].strip.split('&')
    @results = search_results(full_query)
  end

  def full_query
    user_params
      .as_json
      .map { |key, _value| params[key] }
      .join('&')
  end

  def search_results(query)
    search = Search.find_by(query: query) || Search.create(query: query)
    JSON.parse(search.result.json)
  end
end
