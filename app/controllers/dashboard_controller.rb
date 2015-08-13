class DashboardController < ApplicationController
  def show
    @messages = aggregate_messages
  end

  private

  def aggregate_messages
    messages_collection = Tecnico.messages + Agent.messages
    messages_collection.flat_map { |ar_collection| ar_collection.flat_map { |message| message } }
  end
end

