FactoryBot.define do
  factory :edition do
    name { "Edition name" }
    topic { "Edition topic" }
    link { "https://codecraft.com" }
    description { "Editions description" }
    date { Time.parse("2019-06-25T12:00") }
  end
end