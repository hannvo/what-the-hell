class Search < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :result
  has_one_attached :photo
  before_validation :fake_results

  private

  def fake_results
    fake_json = {
      title: "My fake movie",
      year: 2006,
      thumb: 'http://my.image.url.com',
      db_id: 1123
    }.to_json
    self.result = Result.new(json: fake_json)
  end
end
