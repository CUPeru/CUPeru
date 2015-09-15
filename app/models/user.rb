# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  name               :string
#  screenname         :string
#  uid                :string
#  oauth_token        :string
#  oauth_token_secret :string
#

class User < ActiveRecord::Base
  def self.from_omniauth(auth_info)
    if user = find_by(uid: auth_info.extra.raw_info.user_id)
      user
    else
      create({name: auth_info.extra.raw_info.name,
              uid: auth_info.extra.raw_info.user_id,
              oauth_token: auth_info.credentials.token,
              oauth_token_secret: auth_info.credentials.secret
      })
    end
  end
end
