module PagesHelper
  def wins_from_followings user
    @wins = Win.all
  end
end
