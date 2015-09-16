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

