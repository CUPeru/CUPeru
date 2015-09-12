require 'rails_helper'

describe SendsMessages do
  let(:fake_class) do
    class FakeClass
      include SendsMessages
    end
  end

  it 'includes a .messages method' do
    expect(fake_class).to respond_to(:messages)
  end
end
