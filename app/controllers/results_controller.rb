class ResultsController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @res = Result.find(params[:id])
    @result = @res.details unless @res.json.nil?
    FaceRecognition.call(@res)
  end
end
