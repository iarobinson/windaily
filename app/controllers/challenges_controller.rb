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
    @challenges = current_user.challenges if current_user
  end

  def edit
    @users = User.all
  end

  def create
    @challenge = Challenge.new(challenge_params.except(:email))

    if challenge_params[:email]
      submitted_email = challenge_params[:email]
      if User.where({email: submitted_email}).size > 0
        @new_user = User.where({email: challenge_params[:email]}).first
      else
        @new_user = User.new({
          email: submitted_email,
          password: Devise.friendly_token.first(8)
          })
        @new_user.save
      end
    end

    if current_user
      @challenge.users << current_user
    elsif @new_user
      @challenge.users << @new_user
    end

    respond_to do |format|
      if @challenge.save
        if @new_user
          sign_in(:user, @new_user)
          format.html {
            redirect_to edit_user_registration_path(
              user: {
                email: @new_user.email,
                current_password: @new_user.password,
                id: @new_user.id
            }) + "#security-settings-card",
            notice: "Challenge was successfully created. PLEASE SET YOUR PASSWORD: Your current password is: #{@new_user.password}"
          }
          format.json { render :show, status: :created, location: @challenge }
        else
          format.html { redirect_to @challenge, notice: 'Challenge was successfully created.' }
          format.json { render :show, status: :created, location: @challenge }
        end
      else
        format.html { render :new, notice: "Something went wrong..." }
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
        :title, :description, :users, :frequency, :phone, :primary_image, :email
      )
    end
end
