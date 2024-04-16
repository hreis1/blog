FactoryBot.define do
  factory :comment do
    user
    post
    message { Faker::Lorem.paragraph }
  end
end
