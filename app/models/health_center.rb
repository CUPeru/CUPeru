class HealthCenter < ActiveRecord::Base
  has_many :health_posts

  after_create :set_random_code

  def set_random_code
    random = rand(1000..9999).to_s
    update_attributes(code: random)
  end
end
