require 'rails_helper'
require_relative '../../app/poro/emergency'

describe Emergency do

  it 'has a correct initialize' do
    emergency = Emergency.new("Heyo")

    expect(emergency.message).to eq("Heyo")
  end
end
