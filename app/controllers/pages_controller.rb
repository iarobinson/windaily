class PagesController < ApplicationController
  def index
    if current_user && current_user.challenges.size > 0
      @challenges = current_user.challenges
    else
      @challenges = Challenge.all
    end
  end
end
