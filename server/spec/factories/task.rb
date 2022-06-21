FactoryBot.define do
  factory :task do
    name { "MyString" }
    description { "MyText" }
    user_id { 1 }
    list_id { 1 }
  end
  trait :w_task do
    name { '' }
    description { '' }
    user_id { 1 }
    list_id { 1 }
  end
end
