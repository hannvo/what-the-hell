class Search < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :result, optional: true
  has_one_attached :photo

  after_commit :async_update

  private

  def async_update
    CallApiJob.perform_later(self.id)
  end
end
