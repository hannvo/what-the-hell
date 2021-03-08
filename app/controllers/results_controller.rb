class ResultsController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @result = JSON.parse(Result.find(params[:id]).json)
  end
end
