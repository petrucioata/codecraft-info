# frozen_string_literal: true

FactoryBot.define do
  factory :participation do
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
