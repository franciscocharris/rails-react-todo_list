# frozen_string_literal: true

FactoryBot.define do
  factory :list do
    name { Faker::Lorem.word }
    sequence :n_position do |n|
      n
    end
    user_id { create(:user).id }
  end

  trait :w_list do
    name { '' }
    n_position { 1 }
  end
end
