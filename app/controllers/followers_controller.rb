class FollowersController < ApplicationController
  before_action :authenticate_user!

  # TODO: Sanitize these parameters
  def create
    follower = current_user
    followed = User.friendly.find(params[:user_id])
    @follow = Follow.new(follower_id: follower.id, followed_user_id: followed.id)
    respond_to do |format|
      if @follow.save
        format.html { redirect_to user_path(followed), notice: 'Following' }
        format.json { render :show, status: :ok, location: @follow }
      else
        format.html { render :new }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    follower = User.friendly.find(params[:user_id])
    followed = User.friendly.find(params[:id])
    @follow = Follow.where(follower_id: follower.id).where(followed_user_id: followed.id).first
    respond_to do |format|
      if @follow.destroy
        format.html { redirect_to user_path(followed), notice: 'Unfollowed' }
        format.json { render :show, status: :ok, location: followed }
      else
        format.html { render :new }
        format.json { render json: user_path(followed), status: :unprocessable_entity }
      end
    end
  end
end
