module TagParser
  extend self

  TAGS = [:emergency, :symptom].freeze

  # Public. Returns an array of tags pertaining to the message.
  # message - a Message or Twilio::Message object
  def run(message)
    return [] unless message.body.present?
    TAGS.reduce([]) do |tag_list, tag|
      tag_list << tag if message.body.include?(tag.to_s)
      tag_list
    end
  end
end
