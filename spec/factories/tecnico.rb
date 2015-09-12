FactoryGirl.define do
  factory :tecnico do
    name         { Faker::Internet.user_name }
    phone_number { Faker::Number.number(10) }
  end
end
