# Superclass. Each subclass implements a #tokens method that returns a hash of
# token key to content.
#
class Action
  # TODO: (dysnomian) Each of these actions need to be implemented. The Register
  # action is the role model at the moment. The Action superclass contains core
  # functionality for the actions.
  LIST = {
    register: "RegisterAction",
    broadcast: "NullAction",
    auto: "NullAction",
    fw: "NullAction",
    help: "HelpAction",
    info: "NullAction"
  }

  attr_reader :message, :from, :tokens

  @queue = :actions

  # Public. Convenience method for the action list.
  def self.list
    LIST
  end

  def initialize(message)
    @message = message
    @from    = message.from
    @tokens  = parse_tokens
  end

  def type
    tokens.fetch(:type, nil)
  end

  private

  def reply(reply_message)
    TwilioClient.send_text(
      to: message.from,
      from: ENV['twilio_phone_number'],
      body: reply_message)
  end

  def parse_tokens
    # No op. But here's an example of how it might work:
    # {
    #   type: lexed_tokens[0],
    #   rest: lexed_tokens[1..-1]
    # }
  end

  def lexed_tokens
    message.body.downcase.split(" ")
  end
end
