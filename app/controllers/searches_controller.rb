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
    @search.save ? (redirect_to result_path(@result)) : (render :new)
  end

  def show
    @result = Result.find(params[:id])
  end

  def display_result
  end

  private

  def search_params
    params.require(:search).permit(:query, :user, :result, :photo)
  end
end
