class TwilioTextMessenger

  def initialize(phone_number, content)
    @content = content
    @number = clean_phone_number(phone_number)
  end

  def send!
    if valid_and_not_test?
      initialize_sms_client
      msg = @api_client.messages.create(
        from: ENV["TWILIO_NUMBER"],
        to: @number,
        body: @content,
      )
    end
  end

  private

  def initialize_sms_client
    @api_client = Twilio::REST::Client.new(
      ENV["TWILIO_ACCOUNT_SID"],
      ENV["TWILIO_AUTH_TOKEN"]
    )
  end

  def clean_phone_number(phone_number)
    abort_from_invalid_number unless phone_number.present?
    clean_number = phone_number.delete('^0-9')
    if clean_number.length > 10 && clean_number.first == '1'
      clean_number = clean_number.last(10)
    end
    phone_number = clean_number
  end

  def valid_and_not_test?
    return false unless number_valid?
    return false unless content_valid?
    return test_sms_log(@number, @content) if test_number?
    return test_sms_log(@number, @content) if Rails.env.development?
    return test_sms_log(@number, @content) if Rails.env.test?
    true
  end

  def number_valid?
    if @number.length == 10
      true
    else
      false
    end
  end

  def content_valid?
    if @content.present?
      true
    else
      false
    end
  end

  def test_number?
    return false unless @number
    @number.count("5") >= 7
  end

  def test_sms_log(number, content)
    puts ">>>>> #{number}: #{content}" unless Rails.env.test?
    $sms_log = $sms_log || ["No SMS Sent"]
    $sms_log.push("#{number} #{content}")
    false
  end
end
