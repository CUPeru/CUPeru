require_relative 'emergency'
require_relative 'broadcast'

class Parser
  def initialize(message)
    @message = message
    parse_message
  end

  def parse_message
    text = @message.body.downcase
    case text
    when text.include?("broadcast")
      Broadcast.new(@message)
    when text.include?("emergency")
      Emergency.new(@message)
    when text.include?("symptoms")
      Symptom.new(@message)
    end
  end
end
