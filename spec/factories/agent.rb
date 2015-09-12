FactoryGirl.define do
  factory :agent do
    name         { Faker::Name.first_name.downcase }
    phone_number { Faker::Number.number(10).to_s }
  end
end
