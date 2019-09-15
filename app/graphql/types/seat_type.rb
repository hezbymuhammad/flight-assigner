module Types
  class SeatType < Types::BaseObject
    field :code, String, null: false
    field :plane, Types::PlaneType, null: false
  end
end
