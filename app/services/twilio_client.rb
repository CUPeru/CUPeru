module TwilioClient
  extend self

  def send_text(params)
    messages.create(params)
  end

  def fetch_incoming_messages
    incoming_messages.each { |inc_message| create_and_route(inc_message) }
  end

  private

  def client
    @client ||= Twilio::REST::Client.new(
      ENV["twilio_account_sid"],
      ENV["twilio_auth_token"])
  end

  def messages
    client.account.messages
  end

  def incoming_messages
    messages.list(to: ENV['twilio_phone_number'])
  end

  # TODO: (dysnomian) Move to Message class?
  def create_message_from(twilio_message)
    Message.create(
      twilio_sid: twilio_message.sid,
      to:         twilio_message.to,
      from:       twilio_message.from,
      body:       twilio_message.body,
      status:     twilio_message.status)
  end

  def create_and_route(twilio_message)
    unless Message.exists?(twilio_sid: twilio_message.sid)
      message = create_message_from(twilio_message)
      Dispatcher.route(message)
    end
  end
end
