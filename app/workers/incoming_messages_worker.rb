class IncomingMessagesWorker
  @queue = :twilio

  def self.perform
    TwilioClient.fetch_incoming_messages
  end
end
