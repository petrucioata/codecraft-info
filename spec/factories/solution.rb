# frozen_string_literal: true

FactoryBot.define do
  factory :solution do
    participation
    task_id { create(:task, :for_edition).id }
    points { Faker::Number.between(from: 0, to: 300) }

    trait :with_participation do
      before(:create) do |solution, _evaluator|
        create(:participation, solution: [solution])
      end
    end
  end
end
