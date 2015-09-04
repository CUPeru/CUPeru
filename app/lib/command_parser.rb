module CommandParser
  extend self

  COMMANDS = [:auto, :fw, :register].freeze

  # Public. Returns the action pertaining to the message.
  # message - a Message or Twilio::Message object
  def run(symbolized_first_word)
    symbolized_first_word if COMMANDS.include?(symbolized_first_word)
  end
end
