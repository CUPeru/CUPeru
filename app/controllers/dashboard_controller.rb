class DashboardController < ApplicationController
  def show
    messages_collection = Tecnico.messages + Agent.messages
    @messages = []
    messages_collection.map {|arc| arc.map {|m| @messages << m}}
  end
end

