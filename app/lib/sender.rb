require 'deterministic/maybe'

module Sender
  SENDER_TYPES = [Agent, Tecnico, HealthPost, HealthCenter]

  def self.find_by_name(name)
    SENDER_TYPES.map { |klass| klass.find_by(name: name) }.fetch(0)
  end

  def self.find_by_phone_number(number)
    SENDER_TYPES.map { |klass| klass.find_by(phone_number: number) }.fetch(0)
  end
end
