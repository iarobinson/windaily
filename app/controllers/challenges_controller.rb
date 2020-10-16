class ChallengesController < ApplicationController
  before_action :authenticate_user!, only: [:join, :update, :destroy, :edit]
  before_action :set_challenge, only: [:show, :edit, :update, :destroy]

  def index
    @challenges = Challenge.all
  end

  def my_challenges
    @challenges = current_user.challenges
  end

  def add_friend
    @user = User.new
  end

  def my_challenges
    @challenges = []
    Challenge.all.each do |challenge|
      if challenge.users.include?(current_user)
        @challenges << challenge
      end
    end
    @challenges
  end

  def join
    @challenge = Challenge.find(params[:challenge_id])
    if @challenge.users.include?(current_user)
      redirect_to @challenge, notice: 'You\'re already a part of this challenge.'
    else
      @challenge.users << current_user
    end
  end

  def leave
    @challenge = Challenge.find(params[:challenge_id])
    if @challenge.users.include?(current_user)
      @challenge.users.delete(current_user)
      redirect_to my_challenges_path, notice: 'You have left that challenge.'
    else
      redirect_to @challenge, notice: 'You can\'t leave a challenge you\'re not a part of.'
    end
  end

  def show
  end

  def new
    @challenge = Challenge.new
    @users = User.all
  end

  def edit
    @users = User.all
  end

  def create
    @challenge = Challenge.new(challenge_params)
    if current_user
      @challenge.users << current_user
    end

    respond_to do |format|
      if @challenge.save
        format.html { redirect_to @challenge, notice: 'Challenge was successfully created.' }
        format.json { render :show, status: :created, location: @challenge }
      else
        format.html { render :new }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @challenge.update(challenge_params)
        format.html { redirect_to @challenge, notice: 'Challenge was successfully updated.' }
        format.json { render :show, status: :ok, location: @challenge }
      else
        format.html { render :edit }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @challenge.destroy
    respond_to do |format|
      format.html { redirect_to challenges_url, notice: 'Challenge was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_challenge
      @challenge = Challenge.find(params[:id])
    end

    def challenge_params
      params.fetch(:challenge, {}).permit(
        :title, :description, :users, :frequency, :phone, :primary_image
      )
    end
end
