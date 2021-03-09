class Result < ApplicationRecord
  after_create_commit :async_update

  def details
    JSON.parse(json)
  end

  private

  def async_update
    ActorDetailsJob.perform_now(self)
  end
end
