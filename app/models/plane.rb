class Plane < ApplicationRecord
  has_many :seats

  validates_presence_of :name
  validates_presence_of :dimension

  def available_seat
    seats.unoccupied.queued.first
  end

  def assign_seats
    SeatsFactory.new(self).run!
  end
end
