# frozen_string_literal: true

FactoryBot.define do
  factory :position do
    short_name { Faker::FunnyName.unique.name }
    long_name { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Quote.yoda }
  end
end
