# == Schema Information
#
# Table name: messages
#
#  id               :integer          not null, primary key
#  body             :string
#  to               :string
#  from             :string
#  date_sent        :string
#  keyword          :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  messageable_id   :integer
#  messageable_type :string
#  status           :string
#  twilio_sid       :string
#

class Message < ActiveRecord::Base
  validates_uniqueness_of :twilio_sid

  scope :recent,   -> { order(:created_at).last(100).reverse }
  scope :incoming, -> { where(to: ENV['twilio_phone_number']) }
  scope :outgoing, -> { where(from: ENV['twilio_phone_number']) }

  scope :emergencies, -> { select(&:emergency?) }
  scope :broadcasts,  -> { select(&:broadcast?) }

  #Public. Presents a hash of stats.
  def self.stats
    {
      total:       all.count,
      emergencies: emergencies.count,
      broadcasts:  broadcasts.count
    }
  end

  # Public. Returns an array of symbolized tags found in the message body.
  def tags
    TagParser.run(self)
  end

  # Public. Returns an action from the message body if one is found. Otherwise,
  #   returns nil.
  def action
    has_action? ? action_class.new(self) : NullAction.new
  end

  # Public. Renders a hash ready for the Twilio client.
  def to_text
    {
      to:   self.to,
      from: self.from,
      body: self.body
    }
  end

  # Public. Returns true if the body parses for an emergency.
  def emergency?
    tags.include?(:emergency)
  end

  # TODO: Implement when the class exists.
  # Public. Returns true if the action is a broadcast.
  def broadcast?
    false
    # action.is_a?(BroadcastAction)
  end

  # Public. Renders a hash ready for the CSV exporter.
  def to_row
    MessageCSVPresenter.new(self).to_row
  end

  # Public. Returns true if the symbolized first word is in the Action register.
  def has_action?
    Action.list.keys.include?(first_word)
  end

  #Public. returns the short name of the sender if found. Otherwise, returns an
  #empty string.
  def sender_short_name
    return 'CUPeru' if self.from == ENV['twilio_phone_number']
    result = Sender.find_by_phone_number(self.from)
    result.present? ? result.name : ""
  end

  private

  # Private. References the Action list to match the first word to the keys. It
  #   there is a match, it returns the class referenced.
  def action_class
    Action.list.fetch(first_word).constantize if has_action?
  end


  def first_word
    body.downcase.split(" ").first.to_sym
  end
end
