class Registrator
  def initialize(message)
    register_by_number(message)
  end

  def register_by_number(message)
    if Agent.where(phone_number: message.from).empty? && message.body.include?("agent123")
      Agent.create!(phone_number: message.from)
    end

    if Tecnico.where(phone_number: message.from).empty? && message.body.include?("tecnico123")
      Tecnico.create!(phone_number: message.from)
    end
  end
end
