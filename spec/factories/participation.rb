# frozen_string_literal: true

FactoryBot.define do
  factory :participation do
    trait :with_participant do
      transient do
        position_id { 0 }
      end

      before(:create) do |participation, evaluator|
        create(:participant, position_id: evaluator.position_id, participations: [participation])
      end
    end
  end
end
