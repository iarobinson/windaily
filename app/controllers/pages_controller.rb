class PagesController < ApplicationController
  def index
    @challenges = []
    Challenge.all.each do |challenge|
      if challenge.users.include? current_user
        @challenges << challenge
      end
    end
    @challenges
  end
end
