#FIXME: (dysnomian) This just isn't getting enqueued for whatever reason.
class IncomingMessagesWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  sidekiq_options unique: true, retry: 5

  recurrence { minutely(5) }

  def perform(name='IncomingMessagesWorker')
    TwilioClient.fetch_incoming_messages
  end
end
