FactoryBot.define do
  factory :order do
    association :user, factory: :user
    association :seat, factory: :seat
  end
end
