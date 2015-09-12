# == Schema Information
#
# Table name: tecnicos
#
#  id             :integer          not null, primary key
#  phone_number   :string
#  health_post_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  name           :string
#

class Tecnico < ActiveRecord::Base
  include SendsMessages

  belongs_to :health_post
  has_many :messages
  validates_uniqueness_of :phone_number
end
