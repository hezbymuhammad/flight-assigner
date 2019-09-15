module Types
  class OrderType < Types::BaseObject
    field :id, ID, null: false
    field :user, Types::UserType, null: false
    field :seat, Types::SeatType, null: false
    field :plane, Types::PlaneType, null: false
  end
end
