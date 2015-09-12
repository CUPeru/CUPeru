# == Schema Information
#
# Table name: health_centers
#
#  id           :integer          not null, primary key
#  phone_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  code         :string
#

class HealthCenter < ActiveRecord::Base
  include SendsMessages

  has_many     :health_posts
  after_create :set_random_code

  def set_random_code
    random = rand(1000..9999).to_s
    update_attributes(code: random)
  end
end
