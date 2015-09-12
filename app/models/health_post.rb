# == Schema Information
#
# Table name: health_posts
#
#  id               :integer          not null, primary key
#  phone_number     :string
#  health_center_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  code             :string
#

class HealthPost < ActiveRecord::Base
  include SendsMessages

  belongs_to :health_center
  has_many :agents
  has_many :tecnicos

  after_create :set_random_code

  def set_random_code
    random = rand(1000..9999).to_s
    update_attributes(code: random)
  end
end
