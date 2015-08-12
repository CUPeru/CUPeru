require_relative 'sms_registration'
require_relative 'parser'

class MessageHandler
  def route_message(message)
    save_message(message)
    Registrator.new.register_by_number(message) if message.body.downcase.include?("register")
    Parser.new.parse_message(message)
  end

  def save_message(message)
    Message.create(
      body: message.body,
      to: message.to,
      from: message.from,
      date_sent: message.date_created)
  end
 end
