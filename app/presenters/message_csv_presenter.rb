class MessageCSVPresenter
  attr_reader :message

  HEADERS = ["sender", "recipient", "body",
             "tags", "action", "date"]

  def initialize(message)
    @message = message
  end

  def to_row
      [message.from,
      message.to,
      message.body,
      format_tags(message.tags),
      message.action.type,
      message.created_at]
  end

  def headers
    HEADERS
  end

  private

  def format_tags(tags)
    if tags.present?
      tags.map { |tag| tag.to_s.gsub(/:/, '') }.join(" ")
    else
      nil
    end
  end
end
