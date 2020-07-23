class UserMailer < ApplicationMailer
  default from: 'victory@windaily.app'

  def welcome_email
    @user = params[:user]
    @url = 'http://dailywinner.com/login'
    mail(
      to: @user.email,
      subject: "Welcome to the Win Daily App where you challenge your frineds to develop good habits."
    )
  end
end
