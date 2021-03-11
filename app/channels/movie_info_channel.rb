class MovieInfoChannel < ApplicationCable::Channel
  def subscribed
    stream_from "MovieInfo_result_#{params[:client]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
