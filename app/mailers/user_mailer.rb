require 'sendgrid-ruby'
include SendGrid

class UserMailer < ApplicationMailer

  def notify_others_of_win(win)
    #
    # win.challenge.users do |user|
    #
    #   email_text = """
    #   #{win.user.first_name} #{win.user.last_name} (#{win.user.email}) got a win.
    #
    #   #{win.title}
    #
    #   #{win.description}
    #
    #   #{win.challenge.id}
    #   """
    #
    #   from = Email.new(email: "victory@windaily.app", name: "Win Daily")
    #   subject = `#{win.user.first_name} #{win.user.last_name} (#{win.user.email}) got a win`
    #   to = Email.new(email: user.email)
    #   content = Content.new(type: 'text/plain', value: email_text)
    #   mail = SendGrid::Mail.new(from, subject, to, content)
    #
    #   sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    #   response = sg.client.mail._('send').post(request_body: mail.to_json)
    #   p `email sent to #{user.email}`
    # end
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

    Click here to accept this challenge, visit https://www.windaily.app/challenges/#{challenge.id.to_s}.

    Your login email is: #{challenged.email}

    Your login password is: #{temporary_password}

    https://www.windaily.app/challenges/#{challenge.id.to_s}
    """

    from = Email.new(email: "victory@windaily.app", name: "Win Daily")
    subject = 'You have been challenged to develop a new habit with a friend.'
    to = Email.new(email: challenged.email)
    content = Content.new(type: 'text/plain', value: email_text)

    mail = SendGrid::Mail.new(from, subject, to, content)
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
  end

  def you_have_been_invited_to_win_daily(invitor, invitee, temporary_password)
    email_text = """
    You have been invited to WinDaily.app by user with this email: #{invitor.email}

    Your login email is: #{invitee.email}

    Your login password is: #{temporary_password}
    """

    from = Email.new(email: "victory@windaily.app", name: "Win Daily")
    subject = "You have been invited to develop a new habit with #{invitor.email}."
    to = Email.new(email: invitee.email)
    content = Content.new(type: 'text/plain', value: email_text)

    mail = SendGrid::Mail.new(from, subject, to, content)
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
  end
end
