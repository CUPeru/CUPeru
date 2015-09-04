module Dispatcher
  COMMANDS = [:register, :broadcast, :auto, :fw, :help, :info]

  # Public. Routes messages from the received messages endpoint to the
  #   appropriate place.
  def route(message)
    if COMMANDS.include?(message.symbolized_first_word)
      Command.new(message)
    end
  end
end
