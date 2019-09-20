# frozen_string_literal: true

FactoryBot.define do
  factory :participant do
    username { Faker::Lorem.unique.word }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    position { create(:position) }
    link { "https://app.codesignal.com/profile/#{username}" }

    trait :with_participations do
      transient do
        count { 1 }
      end

      after(:create) do |participant, evaluator|
        create_list(:participation, evaluator.count, participant: participant)
      end
    end
  end
end
