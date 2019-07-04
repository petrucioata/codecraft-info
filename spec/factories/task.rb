# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    name { Faker::Lorem.words(2).join('_') }
    author { Faker::FunnyName.name }
    description { Faker::Quote.yoda }

    trait :for_edition do
      edition
    end
  end
end
