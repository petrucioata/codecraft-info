# frozen_string_literal: true

FactoryBot.define do
  factory :participation do
    trait :with_participant do
      transient do
        position { Position.first }
      end

      before(:create) do |participation, evaluator|
        create(:participant, position_id: evaluator.position, participations: [participation])
      end
    end
  end
end
