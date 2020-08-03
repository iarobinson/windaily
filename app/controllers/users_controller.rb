class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    challenge = Challenge.find(params[:user][:challenge_id])
    automatically_generated_password = Devise.friendly_token.first(6)
    @user = User.new user_params
    @user.password = automatically_generated_password
    respond_to do |format|
      if @user.save
        challenge.users << @user
        UserMailer.with(the_challenger: current_user, the_challenged: @user, password: automatically_generated_password).you_have_been_challenged_email.deliver_later
        format.html { redirect_to(challenge_path(challenge), notice: 'User was successfully created.') }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { redirect_to(challenge_path(challenge), notice: 'There was an error saving that user. They may exist.') }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user.avatar.attach(user_params[:avatar]) unless user_params[:avatar].nil?
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_admin_url(@user), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(
        :first_name, :last_name, :avatar, :phone, :email
      )
    end
end
