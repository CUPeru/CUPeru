require_relative 'emergency'
require_relative 'broadcast'

class Parser
  def initialize(message)
    @message = message
    parse_message
  end

  def parse_message
    text = @message.body.downcase
    if  text.include?("broadcast")
      Broadcast.new(@message)
    elsif text.include?("emergency")
      Emergency.new(@message)
    elsif  text.include?("symptoms")
      Symptom.new(@message)
    else
      "I dunno what to do with this message"
    end
  end
end
