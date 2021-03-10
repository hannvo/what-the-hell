class Result < ApplicationRecord
  has_many :searches
  after_create_commit :async_update

  def details
    JSON.parse(json)
  end

  def photo_key
    searches.first.photo.key
  end

  def incomplete?
    json.nil? || json == 'photo_upload' || details['name'].nil?
  end

  private

  def async_update
    return unless json

    ActorDetailsJob.perform_now(self)
  end
end
