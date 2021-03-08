class Result < ApplicationRecord
  after_commit :async_update

  private

  def async_update
    FakeDelayJob.perform_later(self) if json == 'photo'
    return unless json.is_a? Integer

    ActorDetailsJob.perform_later(self)
  end
end
