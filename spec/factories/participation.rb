# frozen_string_literal: true

FactoryBot.define do
  factory :participation do
    participant
    edition
    total_time { Time.at(Faker::Number.between(from: 0, to: 3600)).utc.strftime('%H:%M:%S') }
    total_points { Faker::Number.between(from: 0, to: 900) }

    trait :with_participant do
      transient do
        position { create(:position) }
      end

      before(:create) do |participation, evaluator|
        create(:participant, position: evaluator.position, participations: [participation])
      end
    end
  end
end
