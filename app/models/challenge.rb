class Challenge < ApplicationRecord
  has_one :owner
  has_and_belongs_to_many :users
end
