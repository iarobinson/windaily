class Challenge < ApplicationRecord
  has_and_belongs_to_many :users
  has_one_attached :primary_image
  has_many :wins
  has_one :owner
end
