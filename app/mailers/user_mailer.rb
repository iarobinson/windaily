class UserMailer < ApplicationMailer
  default from: 'team@windaily.com'

  def welcome_email
    @user = params[:user]
    @url = 'http://dailywinner.com/login'
    mail(
      to: @user.email,
      subject: "Welcome to Daily Winner. A place where you work with your frineds to develop good habits."
    )
  end
end
