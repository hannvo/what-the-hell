require 'open-uri'

class FaceRecognition
  @face_url = 'https://actorrecognition-tdevy3cs7a-ew.a.run.app/find_actor_by_pic'

  def self.call(key)
    FaceRecognitionJob.perform_later(
      @face_url,
      Cloudinary::Utils.cloudinary_url(key)
    )
  end
end
