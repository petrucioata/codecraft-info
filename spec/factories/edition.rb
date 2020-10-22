# frozen_string_literal: true

FactoryBot.define do
  dates = (Time.zone.today.beginning_of_month - 10.years).step(Time.zone.today.end_of_month, 31).to_a

  factory :edition do
    name { Faker::Name.first_name }
    topic { Faker::Lorem.sentence }
    link { "https://#{Faker::Company.name}.com" }
    description { Faker::Lorem.sentence }
    date { dates.pop }

    trait :with_participants do
      transient do
        count { 1 }
        position { create(:position) }
      end

      after(:create) do |edition, evaluator|
        create_list(:participant, evaluator.count, position: evaluator.position, editions: [edition])
      end
    end
  end
end
