module TagParser
  extend self

  TAGS = [:emergency, :broadcast, :symptom].freeze

  # Public. Returns an array of tags pertaining to the message.
  # message - a Message or Twilio::Message object
  def run(message)
    TAGS.reduce([]) do |tag_list, tag|
      tag_list << tag if message.body.include?(tag.to_s)
      tag_list
    end
  end
end
