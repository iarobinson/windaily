class Users::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :edit]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
  end

  def edit
  end

  def create
    notification_message = ""
    challenge = Challenge.find(params[:challenge_id]) if params[:challenge_id]
    challenge = Challenge.find(params[:user][:challenge_id]) if params[:user].present? && params[:user][:challenge_id]
    automatically_generated_password = Devise.friendly_token.first(6)

    if User.where(email: params[:email]).exists?
      @user = User.where(email: params[:email]).first
      challenge.users << @user
      UserMailer.you_have_been_challenged_email(current_user, @user, challenge, automatically_generated_password).deliver_later
      notification_message += "This user's email is already on WinDaily, they have been notified of your challenge.\n"
    elsif params[:phone].present? && User.where(phone: params[:phone]).exists?
      @user = User.where(phone: params[:phone]).first
      challenge.users << @user
      UserMailer.you_have_been_challenged_email(current_user, @user, challenge, automatically_generated_password).deliver_later
      notification_message += "This user's phone # is already on WinDaily, they have been notified of your challenge.\n"
    else
      binding.pry
      if params[:email]
        @user = User.new email: params[:email]
      else
        @user = User.new email: user_params[:email]
      end

      if @user[:email].nil?
        @user[:email] = "#{@user.email[/^[^@]+/]}-#{SecureRandom.hex(1)}" + "@windaily.com"
        @user.skip_confirmation!
        text_message = """
          You've been challenged to win daily!
          Your email username is: #{@user[:email]}
          Your login password is: #{automatically_generated_password}
        """
        TwilioTextMessenger.new(@user.phone, text_message).send!
        notification_message += "They have been sent a text with your challenge.\n"
      elsif @user[:phone].nil?
        @user.skip_confirmation!
        email_message = """
          You've been challenged to win daily!
          Your email username is: #{@user[:email]}
          Your login password is: #{automatically_generated_password}
        """
        notification_message += "#{@user.email} have been sent an email with your challenge.\n"
      end
      @user.password = automatically_generated_password
      challenge.users << @user if challenge.present?
    end

    respond_to do |format|
      if @user.save

        binding.pry
        @user.followers << current_user if current_user
        if challenge.present?
          UserMailer.you_have_been_challenged_email(current_user, @user, automatically_generated_password).deliver_later
          format.html { redirect_to(challenge_path(challenge), notice: notification_message) }
          format.json { render json: @user, status: :created, location: @user }
        else
          format.html { redirect_to(community_path, notice: notification_message) }
          format.json { render json: @user, status: :created, location: @user }
        end
      else
        format.html { redirect_to(community_path, notice: 'There was an error saving that user. They may exist.') }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user.avatar.attach(user_params[:avatar]) unless user_params[:avatar].nil?
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_user
      @user = User.friendly.find(params[:id])
    end

    def set_challenge
      params.require(:challenge).permit(params[:id])
      @challenge = Challenge.find(params[:id])
    end

    def user_params
      params.require(:user).permit(
        :first_name, :last_name, :avatar, :phone, :email, :moniker, :payment_plan, :challenge_id
      )
    end
end
