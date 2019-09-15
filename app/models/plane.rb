class Plane < ApplicationRecord
  has_many :seats

  def available_seat
    seats.unoccupied.queued.first
  end
end
