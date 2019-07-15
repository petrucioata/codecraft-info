# frozen_string_literal: true

FactoryBot.define do
  factory :edition do
    name { Faker::Name.first_name }
    topic { Faker::Lorem.sentence }
    link { "https://#{Faker::Company.name}.com" }
    description { Faker::Lorem.sentence }
    date { Faker::Time.between(DateTime.now.utc - 1, DateTime.now.utc) }

    trait :with_participants do
      transient do
        count { 1 }
      end

      after(:create) do |edition, evaluator|
        create_list(:participant, evaluator.count, editions: [edition])
      end
    end
  end
end
