# frozen_string_literal: true

FactoryBot.define do
  factory :participation do
    participant
    edition
    total_time { Time.at(Faker::Number.between(0, 3600)).utc.strftime('%H:%M:%S') }
    total_points { Faker::Number.between(0, 900) }
  end
end
