require 'open-uri'

class FaceRecognitionJob < ApplicationJob
  queue_as :default

  def perform(api_url, img_url)
    response = URI.open(
      api_url,
      "url" => img_url
    )
    JSON.parse(response.string)
  end
end
