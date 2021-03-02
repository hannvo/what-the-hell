class Search < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :result
  has_one_attached :photo
end
