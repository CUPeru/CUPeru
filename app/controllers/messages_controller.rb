class MessagesController < ApplicationController
  expose(:messages)

  def index
    messages
  end
end
