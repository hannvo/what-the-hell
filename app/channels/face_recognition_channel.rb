class FaceRecognitionChannel < ApplicationCable::Channel
  def subscribed
    client = params[:client]
    stream_for client
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
