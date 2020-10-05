# frozen_string_literal: true

FactoryBot.define do
  dates = (DateTime.new(2000, 12).to_date..DateTime.new(2019, 12).to_date).select { |d| d.day == 1 }

  factory :edition do
    name { Faker::Name.first_name }
    topic { Faker::Lorem.sentence }
    link { "https://#{Faker::Company.name}.com" }
    description { Faker::Lorem.sentence }
    date { dates.pop }

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
