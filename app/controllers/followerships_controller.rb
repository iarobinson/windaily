class FollowershipsController < ApplicationController
  before_action :set_followership, only: [:show, :edit, :update]
  before_action :authenticate_user!

  def index
    @followerships = Followership.all
  end

  def show
  end

  def new
    @followership = Followership.new
  end

  def edit
  end

  def create
    # binding.pry
    @user_to_be_followed = User.friendly.find(params[:follower_id])
    @followership = current_user.followerships.build(user_id: params[:follower_id], follower_id: current_user.id)

    respond_to do |format|
      if @followership.save
        format.html { redirect_to users_path, notice: "" }
        format.json { render :show, status: :created, location: @followership }
      else
        format.html { render :new, notice: "Something went wrong." }
        format.json { render json: @followership.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @followership.update(followership_params)
        format.html { redirect_to @followership, notice: 'Followership was successfully updated.' }
        format.json { render :show, status: :ok, location: @followership }
      else
        format.html { render :edit }
        format.json { render json: @followership.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @followership = current_user.followerships.find(params[:id])
    @followership.destroy
    respond_to do |format|
      format.html { redirect_to followerships_url, notice: 'Followership was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def followers
    @followers = []
    Followership.where(follower_id: current_user).each do |followership|
      @followers << User.find(followership.user_id)
    end
    @followers
  end

  def following
    @the_people_this_user_follows = []
    Followership.where(user_id: current_user).each do |followership|
      @the_people_this_user_follows << User.find(followership.follower_id)
    end
    @the_people_this_user_follows
  end

  private
    def set_followership
      @followership = Followership.find(params[:id])
    end

    def followership_params
      params.require(:followership).permit(:user_id, :friend_id)
    end
end
