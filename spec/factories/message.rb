FactoryGirl.define do
  factory :message do
      from { Faker::Number.number(10) }
      to   { Faker::Number.number(10) }
      body { Faker::Lorem.sentence(1) }

    factory :incoming_message do
      to   { ENV['twilio_phone_number'] }
      from { Faker::Number.number(10) }
      body { Faker::Lorem.sentence(1) }

      trait :register do
        body { "register agent #{Faker::Internet.user_name}" }
      end

      trait :help do
        body { "help" }
      end

      trait :fw do
        body { "fw #{Faker::Number.number(10)}" }
      end

      trait :auto do
        body { "auto set #{Faker::Lorem.sentence(1)}" }
      end

      after(:create) do |message|
        create(:agent, phone_number: message.from)
      end
    end

    factory :outgoing_message do
      to   { Faker::PhoneNumber.cell_phone }
      from { ENV['twilio_phone_number'] }
      body { Faker::Lorem.sentence(1) }

      after(:create) do |message|
        create(:agent, phone_number: message.to)
      end
    end
  end
end
