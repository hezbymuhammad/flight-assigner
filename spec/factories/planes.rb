FactoryBot.define do
  factory :plane do
    name { FFaker::Name.unique.name }
  end
end
