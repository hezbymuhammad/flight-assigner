class Plane < ApplicationRecord
  has_many :seats

  validates_presence_of :name
  validates_presence_of :dimension

  validates_with DimensionValidator, unless: :prototype_only

  after_commit :assign_seats, unless: :prototype_only

  def available_seat
    seats.unoccupied.queued.first
  end

  def parsed_dimension
    @parsed_dimension ||= JSON.parse(dimension)
  end

  private def assign_seats
    SeatsFactoryService.new(self).run
  end
end
