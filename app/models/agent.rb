class Agent < ActiveRecord::Base
  belongs_to :health_post
  validates_uniqueness_of :phone_number
end
