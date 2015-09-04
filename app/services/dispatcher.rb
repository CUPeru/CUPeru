module Dispatcher
  extend self

  # Public. Routes messages from the received messages endpoint to the
  #   appropriate place.
  def route(message)
    message.action.perform
  end
end
