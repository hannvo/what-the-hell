require "open-uri"

class FaceRecognition
  @face_url = "https://wthactorsname-tdevy3cs7a-ew.a.run.app/find_actor_by_pic"

  def self.call(result)
    FaceRecognitionJob.perform_later(
      @face_url,
      result.id
    )
  end
end
