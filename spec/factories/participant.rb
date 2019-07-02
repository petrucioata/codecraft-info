# frozen_string_literal: true

FactoryBot.define do
  factory :participant do
    username { Faker::Lorem.unique.word }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    position { create(:position) }
    link { "https://app.codesignal.com/profile/#{username}" }
  end
end
