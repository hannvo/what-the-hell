class SearchesController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @search = Search.new
  end

  def create
    @search = Search.new(search_params)
    @result = Result.new
    @search.result = @result
    @search.user = current_user if user_signed_in?
    @search.save ? (redirect_to search_preresults_path(@search)) : (render :new)
  end

  def show
    @search = Search.find(params[:id])
  end

  def second_search
    # search result are processed here
    @search = Search.find(params[:id])
    redirect_to search_results_path(@search)
  end

  def final_results
    @search = Search.find(params[:id])
  end

  private

  def search_params
    params.require(:search).permit(:query, :user, :result, :photo)
  end
end
