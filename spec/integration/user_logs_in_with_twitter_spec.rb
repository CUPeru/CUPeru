require 'rails_helper'

describe "logging in" do
  before(:each) do
    stub_omniauth
  end

  it "twitter login" do
    visit "/"
    expect(page.status_code).to eq(200)
    click_link "Login"
    expect(page).to have_content("Logout")
  end
end

def stub_omniauth
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
    provider: 'twitter',
    extra: {
      raw_info: {
        user_id: "1234",
        name: "Horace",
        screen_name: "worace",
      }
    },
    credentials: {
      token: "pizza",
      secret: "secretpizza"
    }
  })
end
