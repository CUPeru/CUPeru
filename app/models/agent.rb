class Agent < ActiveRecord::Base
  belongs_to :health_post
  has_many :messages, as: :messageable
  validates_uniqueness_of :phone_number

  def self.messages
    all.map(&:messages)
  end
end
