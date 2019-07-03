# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    name { Faker::Lorem.sentence }
    author { Faker::FunnyName.name }
    description { Faker::Quote.yoda }
    edition { create(:edition) }
  end
end
