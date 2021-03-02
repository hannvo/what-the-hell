class SearchesController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @search = Search.new()
  end

  def create
    @search = Search.new()
  end
end
