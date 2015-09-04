# Takes a Message instance and parses its body as a register command.
require 'errors'

class RegisterAction < Action
  attr_reader :sender_class, :username

  SENDER_CLASSES = {
    'agent':   Agent,
    'post':    HealthPost,
    'tecnico': Tecnico,
    'center':  HealthCenter
  }

  def perform
    tokens[:sender_class].create(name: tokens[:username], phone_number: from)
  end

  private

  def parse_tokens
    {
      type: lexed_tokens[0],
      sender_class: sender_class_token_to_class(lexed_tokens[1]),
      username: lexed_tokens[2]
    }
  end

  def sender_class_token_to_class(token)
    SENDER_CLASSES.fetch(token.to_sym, NullSender)
  end
end
