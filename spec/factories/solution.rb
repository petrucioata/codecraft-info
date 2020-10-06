# frozen_string_literal: true

FactoryBot.define do
  factory :solution do
    participation
    task
    points { Faker::Number.between(0, 300) }

    trait :with_participation do
      before(:create) do |solution, _evaluator|
        create(:participation, solution: [solution])
      end
    end
  end
end
