class Registrator
  def register_by_number(message)
    if message.body.downcase.include?("register")
      words = message.body.split(" ")
      name = words[1]
      message_code = words[2]
      health_post = HealthPost.find_by(code: message_code)

      if Agent.where(phone_number: message.from).empty? && message.body.include?("agent")
        health_post.agents.create!(phone_number: message.from, name: name)
      elsif Tecnico.where(phone_number: message.from).empty? && message.body.include?("tecnico")
        health_post.tecnicos.create!(phone_number: message.from, name: name)
      elsif HealthPost.where(phone_number: message.from).empty? && message.body.include("post")
        health_center = HealthCenter.find_by(code: message_code)
        health_center.health_posts.create!(phone_number: message.from)
      else
        "Sorry, can't register that number"
      end
    end
  end
end
