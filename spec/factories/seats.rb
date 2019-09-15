FactoryBot.define do
  factory :seat do
    association :plane, factory: :plane, dimension: '[]', prototype_only: true
    section_idx { rand(1..10) }
    column_idx { rand(1..10) }
    row_idx { rand(1..10) }
  end
end
