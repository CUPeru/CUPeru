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
    if valid?
      tokens[:sender_class].create(name: tokens[:username], phone_number: from)
      reply(confirmation_message)
    else
      # TODO: (dysnomian) Use a translation file instead.
      reply(HelpAction.new(message).send(:general_help))
    end
  end

  def valid?
    tokens[:username] && tokens[:sender_class] != NullSender
  end

  private

  def confirmation_message
    "You are now registered as #{tokens[:username]}."
  end

  def parse_tokens
    {
      type: lexed_tokens[0],
      sender_class: sender_class_token_to_class(lexed_tokens[1]),
      username: lexed_tokens.fetch(2, nil)
    }
  end

  def sender_class_token_to_class(token)
    SENDER_CLASSES.fetch(token.try(:to_sym), NullSender)
  end
end
