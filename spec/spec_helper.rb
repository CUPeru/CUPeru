require 'factory_girl'
require './spec/helpers/omniauth_helper'
require 'coveralls'

Coveralls.wear!

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include OmniAuthHelper

  config.before(:all) do
    stub_omniauth
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning { example.run }
  end


  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.order = :random
  Kernel.srand config.seed
end
