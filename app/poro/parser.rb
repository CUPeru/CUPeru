require_relative 'emergency'
require_relative 'broadcast'
require_relative 'symptom'

class Parser
  def parse_message(twilio_message)
    db_message(twilio_message)
    text = twilio_message.body.downcase
    [Broadcast, Emergency, Symptom].each do |poro|
      if text.include?(poro.to_s.downcase)
        @db_message.update_attributes(keyword: poro.to_s) if @db_message
        poro.new(twilio_message)
      end
    end
  end

  def find_worker(message)
    agent   = Agent.find_by(phone_number: message.from)
    tecnico = Tecnico.find_by(phone_number: message.from)
    return agent   if agent
    return tecnico if tecnico
  end

  def db_message(twilio_message)
    worker      = find_worker(twilio_message)
    @db_message = Message.find_by(body: twilio_message.body)
    @db_message.update_attributes(messageable_id: worker.id, messageable_type: worker.class) if worker
  end
end
