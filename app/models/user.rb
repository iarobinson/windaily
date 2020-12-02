class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :omniauthable
  include FriendlyId
  friendly_id :moniker, use: :slugged
  before_save :generate_slug

  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :validatable,
       :confirmable, :lockable, :timeoutable, :trackable

  has_and_belongs_to_many :challenges
  has_one_attached :avatar, dependent: :destroy
  has_many :wins, dependent: :destroy

   def thumbnail
     return self.avatar.variant(resize: "150x150!").processed
   end

   enum payment_plan: [:free, :first_class, :partner_class]
   enum visibility: [:only_you, :the_whole_world]

   # Empower Following
   has_many :received_follows, foreign_key: :followed_user_id, class_name: "Follow"
   has_many :followers, through: :received_follows, source: :follower
   has_many :given_follows, foreign_key: :follower_id, class_name: "Follow"
   has_many :followings, through: :given_follows, source: :followed_user

   def win_count_for_the_day hoy
     hoy_formatted = [hoy.month, hoy.day]
     win_count = 0
     self.wins.each do |win|
       if hoy_formatted == [win.created_at.month, win.created_at.day]
         win_count += 1
       end
     end
     win_count
   end

   def generate_slug
     return slug if self.slug
     automated_slug = ""
     i = 0
     while i <= self.email.length
       break if self.email[i] == "@"
       automated_slug += self.email[i]
       i += 1
     end
     self.slug = automated_slug
   end
end
