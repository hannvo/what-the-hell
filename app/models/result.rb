class Result < ApplicationRecord
  after_commit :async_update

  private

  def async_update
    return unless json.is_a? Integer

    ActorDetailsJob.perform_later(self)
  end
end
