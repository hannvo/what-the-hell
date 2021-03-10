class ResultsController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @result = Result.find(params[:id])
    FaceRecognition.call(@result) if @result.incomplete? && @result.searches.present?
  end
end
