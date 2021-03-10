class CastChannel < ApplicationCable::Channel
  def subscribed
    stream_from "CastMatcher_result_#{params[:client]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
