class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         # :confirmable, :lockable, :timeoutable, :trackable

   has_and_belongs_to_many :challenges
   has_one_attached :avatar
   has_many :wins

   def thumbnail
     return self.avatar.variant(resize: "150x150!").processed
   end
end
