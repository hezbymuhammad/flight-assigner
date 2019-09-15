class Order < ApplicationRecord
  belongs_to :user
  belongs_to :seat, optional: true
  belongs_to :plane

  before_create :assign_seat
  after_commit :mark_seat_as_occupied

  private def assign_seat
    self.seat = plane.available_seat
  end

  private def mark_seat_as_occupied
    self.seat.mark_as_occupied!
  end
end
