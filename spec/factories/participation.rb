# frozen_string_literal: true

FactoryBot.define do
  factory :participation do
    participant
    edition
    total_time { Time.at(Faker::Number.between(0, 3600)).utc.strftime('%H:%M:%S') }
    total_points { Faker::Number.between(0, 900) }

    trait :with_participant do
      transient do
        position { 1 }
      end

      before(:create) do |participation, evaluator|
        create(:participant, position_id: evaluator.position, participations: [participation])
      end
    end
  end
end
