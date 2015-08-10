class Registrator
  def initialize(message)
    parse_message(message)
  end

  def parse_message(message)
    if Agent.where(phone_number: message.from).empty? && message.body.include?("agent123")
      Agent.create!(phone_number: message.from)
    end

    if Tecnico.where(phone_number: message.from).empty? && message.body.include?("tecnico123")
      Tecnico.create!(phone_number: message.from)
    end
  end
end
