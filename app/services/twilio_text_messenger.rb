require 'twilio-ruby'

class TwilioTextMessenger
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def perform
    client = Twilio::REST::Client.new(ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"])
    client.messages.create({
      from: Rails.application.secrets.twilio_phone_number,
      to: ENV["IAN_PHONE"],
      body: message
    })
  end
end
