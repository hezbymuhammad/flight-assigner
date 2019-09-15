class Order < ApplicationRecord
  belongs_to :user
  belongs_to :seat
  belongs_to :plane

  before_create :assign_seat

  private

  def assign_seat
    self.seat = plane.available_seat
  end
end
