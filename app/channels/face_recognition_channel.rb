class FaceRecognitionChannel < ApplicationCable::Channel
  def subscribed
    stream_from "FaceRecognition_result_#{params[:client]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
