class MovieRecommendationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "MovieRecommendation_result_#{params[:client]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
