class PagesController < ApplicationController
  def index
    if current_user
      @challenges = current_user.challenges
    else
      @challenges = Challenge.all
    end
  end
end
