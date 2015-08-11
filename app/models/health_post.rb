class HealthPost < ActiveRecord::Base
  belongs_to :health_center
  has_many :agents
  has_many :tecnicos

  after_create :set_random_code

  def set_random_code
    random = rand(1000..9999).to_s
    update_attributes(code: random)
  end
end
