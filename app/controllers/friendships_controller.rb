class FriendshipsController < ApplicationController
  before_action :set_friendship, only: [:show, :edit, :update]

  def index
    @friendships = Friendship.all
  end

  def show
  end

  def new
    @friendship = Friendship.new
  end

  def edit
  end

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    respond_to do |format|
      if @friendship.save
        format.html { redirect_to users_path, notice: 'Friend added.' }
        format.json { render :show, status: :created, location: @friendship }
      else
        format.html { render :new, notice: 'Something went wrong...' }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @friendship.update(friendship_params)
        format.html { redirect_to @friendship, notice: 'Friendship was successfully updated.' }
        format.json { render :show, status: :ok, location: @friendship }
      else
        format.html { render :edit }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @friendship = current_user.friendships.find(friendship_params[:id])
    @friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to current_user
  end

  private

    def set_friendship
      @friendship = Friendship.find(params[:id])
    end

    def friendship_params
      params.require(:friendship).permit(:user_id, :friend_id)
    end
end
