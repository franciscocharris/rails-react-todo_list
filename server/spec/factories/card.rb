# frozen_string_literal: true

FactoryBot.define do
  factory :card do
    name { Faker::Lorem.word }
    n_position { 1 }
    user_id { create(:user).id }
  end

  trait :user1 do
    user_id { 1 }
  end
end
