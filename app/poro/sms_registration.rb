class Registrator
  def register_by_number(message)
    words = message.body.split(" ")
    type, name, code = words[1], words[2], words[3]
    health_post = HealthPost.find_by(code: code)
    health_center = HealthCenter.find_by(code: code)

    if Agent.where(phone_number: message.from).empty? && type == "agent"
      health_post.agents.create!(phone_number: message.from, name: name)
    elsif Tecnico.where(phone_number: message.from).empty? && type == "tecnico"
      health_post.tecnicos.create!(phone_number: message.from, name: name)
    elsif HealthPost.where(phone_number: message.from).empty? && type == "post"
      health_center.health_posts.create!(phone_number: message.from)
    else
      "Sorry, can't register that number"
    end
  end
end
