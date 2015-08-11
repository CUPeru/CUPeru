class Registrator
  def register_by_number(message)
    words = message.body.split(" ")
    type, name, code = words[1..3]
    health_post = HealthPost.find_by(code: code)
    health_center = HealthCenter.find_by(code: code)

    case type
    when "agent"
      health_post.agents.create(phone_number: message.from, name: name)
    when "tecnico"
      health_post.tecnicos.create(phone_number: message.from, name: name)
    when "post"
      health_center.health_posts.create(phone_number: message.from)
    end
  end
end
