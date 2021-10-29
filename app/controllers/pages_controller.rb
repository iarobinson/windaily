class PagesController < ApplicationController
  include PagesHelper

  def add
    if current_user
      @user = User.new
      @challenge = Challenge.new
      @users = User.all
      @followers = current_user.followers
      @followings = current_user.followings
      @challenges = current_user.challenges
    else
      redirect_to root_path, notice: "You must create an account to view this page."
    end
  end

  def community
    if current_user
      @user = User.new
      @users = User.all
      @followers = current_user.followers
      @followings = current_user.followings
      @wins = Win.all
    else
      redirect_to root_path, notice: "You must create an account to view this page."
    end
  end

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

  def society_gain
    
  end
end
