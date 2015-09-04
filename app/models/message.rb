require 'deterministic/maybe'

class Message < ActiveRecord::Base

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

  # Public. Returns true if the symbolized first word is in the Action register.
  def has_action?
    Action.list.keys.include?(first_word)
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
