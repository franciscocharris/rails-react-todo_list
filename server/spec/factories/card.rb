# frozen_string_literal: true

FactoryBot.define do
  factory :card do
    name { Faker::Lorem.word }
    sequence :n_position do |n|
      n
    end
    user_id { create(:user).id }
  end
end
