class Win < ApplicationRecord
  belongs_to :user
  belongs_to :challenge
  has_many_attached :images
end
