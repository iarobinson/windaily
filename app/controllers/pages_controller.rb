class PagesController < ApplicationController
  include PagesHelper
  def index
    if current_user && current_user.challenges.size > 0
      @challenges = current_user.challenges
    else
      @challenges = Challenge.all
    end
    @wins = wins_from_followings current_user
  end

  def office
    @ignore_normal_layout = true
  end
end
