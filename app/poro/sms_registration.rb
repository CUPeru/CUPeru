class Registrator
  def initialize(message)
    register_by_number(message)
  end

  def register_by_number(message)
    byebug
    if Agent.where(phone_number: message.from).empty? && message.body.include?("agent123")
      Agent.create!(phone_number: message.from)
    elsif Tecnico.where(phone_number: message.from).empty? && message.body.include?("tecnico123")
      Tecnico.create!(phone_number: message.from)
    elsif HealthCenter.where(phone_number: message.from).empty? && message.body.include?("health123")
      HealthCenter.create!(phone_number: message.from)
    else
      "Sorry, can't register that number"
    end
  end
end
