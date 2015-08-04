class HealthPost < ActiveRecord::Base
  belongs_to :health_center
  has_many :agents
  has_many :tecnicos
end
