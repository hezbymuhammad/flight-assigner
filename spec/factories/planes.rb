FactoryBot.define do
  factory :plane do
    name { FFaker::Name.unique.name }

    trait :with_unoccupied_seats do
      after(:create) do |plane|
	create_list :seat, 2, plane: plane, occupied: false
      end
    end
  end
end
