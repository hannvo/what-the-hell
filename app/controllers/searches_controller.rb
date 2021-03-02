class SearchesController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @search = Search.new(query: params[:query]) || Search.new
  end

  def create
    @search = Search.new(search_params)
    @result = Result.new
    @search.result = @result
    @search.user = current_user if user_signed_in?
    @search.save ? (redirect_to root_path(query: @search.query)) : (render :new)
  end

  private

  def search_params
    params.require(:search).permit(:query, :user, :result, :photo)
  end
end
