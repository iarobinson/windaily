class Follow < ApplicationRecord
  # Thank you Leizl Samano
  # https://medium.com/better-programming/how-to-create-a-follow-feature-in-rails-by-aliasing-associations-30d63edee284
  belongs_to :follower, foreign_key: :follower_id, class_name: "User"
  belongs_to :followed_user, foreign_key: :followed_user_id, class_name: "User"
end
