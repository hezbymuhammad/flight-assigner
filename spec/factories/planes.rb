FactoryBot.define do
  factory :plane do
    name { FFaker::Name.unique.name }
    dimension { '[[5,5]]' }
  end
end
