class DashboardController < ApplicationController
  def show
    messages_collection = Tecnico.messages + Agent.messages
    @messages = []
    messages_collection.map { |ar_collection| ar_collection.map { |message| @messages << message } }
  end
end

