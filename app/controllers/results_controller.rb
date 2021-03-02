class ResultsController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @result = Result.find(params[:id])
    @search = @result.search
  end
end
