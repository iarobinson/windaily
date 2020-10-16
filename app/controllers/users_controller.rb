class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update]
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

  def edit
  end

  def create
    challenge = Challenge.find(params[:user][:challenge_id])
    if User.where(email: user_params[:email]).exists?
      @user = User.where(email: user_params[:email]).first
      challenge.users << @user
      UserMailer.you_have_been_challenged_email(current_user, @user, challenge, automatically_generated_password).deliver_later
    elsif User.where(phone: user_params[:phone]).exists?
      @user = User.where(phone: user_params[:phone]).first
      challenge.users << @user
      UserMailer.you_have_been_challenged_email(current_user, @user, challenge, automatically_generated_password).deliver_later
    else
      automatically_generated_password = Devise.friendly_token.first(6)
      @user = User.new user_params
      if @user[:email].empty?
        @user[:email] = "#{@user.email[/^[^@]+/]}-#{SecureRandom.hex(1)}" + "@windaily.com"
        @user.skip_confirmation!
        text_message = """
          You've been challenged to win daily!
          Your email password is: #{@user[:email]}
          Your login password is: #{automatically_generated_password}
        """
        TwilioTextMessenger.new(@user.phone, text_message).send!
      end
      @user.password = automatically_generated_password
      challenge.users << @user
    end

    respond_to do |format|
      if @user.save
        format.html { redirect_to(challenge_path(challenge), notice: 'User added.') }
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
      @user = User.find(params[:id])
    end

    def set_challenge
      params.require(:challenge).permit(params[:id])
      @challenge = Challenge.find(params[:id])
    end

    def user_params
      params.require(:user).permit(
        :first_name, :last_name, :avatar, :phone, :email, :moniker
      )
    end
end
