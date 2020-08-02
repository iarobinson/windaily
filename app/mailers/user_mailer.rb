require 'sendgrid-ruby'
include SendGrid

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

  def you_have_been_challenged_email
    # @user = params[:user]
    # @url = 'http://dailywinner.com/login'
    # mail(
    #   to: @user.email,
    #   subject: "Welcome to the Win Daily App where you challenge your frineds to develop good habits."
    # )

    from = Email.new(email:  @the_challenged.email)
    subject = 'You have been challenged to develop a new habit with a friend.'
    to = Email.new(email: @the_challenger.email)
    content = Content.new(type: 'text/plain', value: 'This should be the content of the email... windaily!')
    mail = Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
  end
end
