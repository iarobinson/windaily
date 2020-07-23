require 'twilio-ruby'

class TwilioTextMessenger
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def perform
    client = Twilio::REST::Client.new("AC34423d49b65ab33230fbc9eee3527dd1", "f55bbe07cb90091bd209c9281283ff81")
    client.messages.create({
      from: Rails.application.secrets.twilio_phone_number,
      to: '+13476883697',
      body: message
    })
  end
end
