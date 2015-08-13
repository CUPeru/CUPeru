require_relative 'sms_registration'
require_relative 'parser'
require 'net/http'

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
    json = message.as_json
    my_connection = Net::HTTP.new('https://dry-badlands-4527.herokuapp.com')
    reponse = my_connection.post('/v1/messages', json) if Rails.env.production?
  end
end
