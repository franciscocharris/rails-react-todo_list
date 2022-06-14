# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { '12345678' }
  end

  trait :w_user do
    first_name { '' }
    last_name { Faker::Name.last_name }
    sequence :email do |n|
      "#{n}"
    end
    password { '123' }
  end

  trait :to_logg do
    email { 'user@gmail.com' }
    password { '12345678' }
  end
end
