class Plane < ApplicationRecord
  has_many :seats

  validates_presence_of :name

  def available_seat
    seats.unoccupied.queued.first
  end
end
