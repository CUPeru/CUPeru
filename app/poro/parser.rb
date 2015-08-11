require_relative 'emergency'
require_relative 'broadcast'
require_relative 'symptom'

class Parser
  def parse_message(twilio_message)
    text = twilio_message.body.downcase
    db_message = Message.find_by(body: twilio_message.body)
    if text.include?("broadcast")
      db_message.update_attributes(keyword: "Broadcast") if db_message
      Broadcast.new.alert(twilio_message)
    elsif text.include?("emergency")
      db_message.update_attributes(keyword: "Emergency") if db_message
      Emergency.new(twilio_message)
    elsif  text.include?("symptoms")
      db_message.update_attributes(keyword: "Symptom") if db_message
      Symptom.new(twilio_message)
    else
      "I dunno what to do with this message"
    end
  end
end
