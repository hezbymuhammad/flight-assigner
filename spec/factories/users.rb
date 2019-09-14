FactoryBot.define do
  factory :user do
    username { FFaker::Internet.user_name }
    email { FFaker::Internet.email }
    password { "test0)" }
  end
end
