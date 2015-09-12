module TwilioClient
  extend self

  def send_text(params)
    messages.create(params) if Rails.env == 'production'
  end

  def messages
    client.account.messages
  end

  private

  def client
    @client ||= Twilio::REST::Client.new(
      ENV["twilio_account_sid"],
      ENV["twilio_auth_token"])
  end
end
