class Seat < ApplicationRecord
  belongs_to :plane

  validates_presence_of :section_idx
  validates_presence_of :column_idx
  validates_presence_of :row_idx

  scope :unoccupied, -> { where(occupied: false) }
  scope :queued, -> { order(:queue_number) }

  def mark_as_occupied!
    update(occupied: true)
  end

  def code
    "#{section_idx}#{column_idx}-#{row_idx}"
  end
end
