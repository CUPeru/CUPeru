require_relative 'sms_registration'
require_relative 'parser'
require 'httparty'

class MessageHandler
  def route_message(message)
    save_message(message)
    Registrator.new.register_by_number(message) if message.body.downcase.include?("register")
    Parser.new.parse_message(message)
  end

  def save_message(message)
    message = Message.create(
      body: message.body,
      to: message.to,
      from: message.from,
      date_sent: message.date_created)

    post_to_api(message)
  end

  def post_to_api(message)
    message_hash = {"message": {"to":message.to, "from":message.from, "body":message.body}}
    HTTParty.post('https://dry-badlands-4527.herokuapp.com/v1/messages', message_hash) if Rails.env.production?
  end
end
