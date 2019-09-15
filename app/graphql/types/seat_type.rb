module Types
  class SeatType < Types::BaseObject
    field :code, String, null: false
    field :plane, Types::PlaneType, null: false
    field :queue_number, Integer, null: false
  end
end
