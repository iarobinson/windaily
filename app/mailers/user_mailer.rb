require 'sendgrid-ruby'
include SendGrid

class UserMailer < ApplicationMailer
  default from: 'victory@windaily.app'

  def notify_others_of_win(win)

    binding.pry
    win.challenge.users do |user|

      email_text = """
      #{win.user.first_name} #{win.user.last_name} (#{win.user.email}) got a win.

      #{win.title}

      #{win.description}

      #{challenge_url(win.challenge)}
      """

      from = Email.new(email: "victory@windaily.app", name: "Win Daily")
      subject = `#{win.user.first_name} #{win.user.last_name} (#{win.user.email}) got a win`
      to = Email.new(email: user.email)
      content = Content.new(type: 'text/plain', value: email_text)
      mail = SendGrid::Mail.new(from, subject, to, content)

      sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
      response = sg.client.mail._('send').post(request_body: mail.to_json)
      p `email sent to #{user.email}`
    end
  end

  def you_have_been_challenged_email(challenger, challenged, challenge, temporary_password)
    @temporary_password = temporary_password
    @challenge = challenge
    @challenged = challenged
    @challenger = challenger

    email_text = """
    You have been challenged to develop the following habit:

    #{challenge.title}

    #{challenge.description}

    You have been challenged by a user with the following email: #{challenger.email}

    To accept this challenge, visit #{challenges_path(challenge)}.

    Your login email is: #{challenged.email}

    Your login password is: #{temporary_password}

    https://www.windaily.app
    """

    from = Email.new(email: "victory@windaily.app", name: "Win Daily")
    subject = 'You have been challenged to develop a new habit with a friend.'
    to = Email.new(email: challenged.email)
    content = Content.new(type: 'text/plain', value: email_text)
    mail = SendGrid::Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
  end
end
