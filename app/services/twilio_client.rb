module TwilioClient
  extend self

  def send_text(params)
    messages.create(params)
  end

  def fetch_incoming_messages
    incoming_messages.each { |t_message| Message.create_from(t_message) }
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
end
