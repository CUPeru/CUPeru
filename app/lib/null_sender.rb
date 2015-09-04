class NullSender
  def self.create(_)
    raise InvalidRegistrationError
  end
end
