class Challenge < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :wins
  has_one :owner
end
