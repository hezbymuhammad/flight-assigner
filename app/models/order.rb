class Order < ApplicationRecord
  belongs_to :user
  belongs_to :seat, optional: true
  belongs_to :plane

  validate :available_seat_exists, if: -> { plane.present? }

  before_create :assign_seat
  after_commit :mark_seat_as_occupied

  private def assign_seat
    self.seat = plane.available_seat
  end

  private def mark_seat_as_occupied
    self.seat.mark_as_occupied!
  end

  private def available_seat_exists
    if plane.available_seat.blank?
      self.errors[:base] << 'All seats are occupied'
    end
  end
end
