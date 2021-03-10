require 'open-uri'

class FaceRecognition
  @face_url = 'https://actorrecognition-tdevy3cs7a-ew.a.run.app/find_actor_by_pic'

  def self.call(result)
    FaceRecognitionJob.perform_later(
      @face_url,
      result
    )
  end
end
