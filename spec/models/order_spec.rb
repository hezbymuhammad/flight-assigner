require 'rails_helper'

describe Order, type: :model do
  let(:plane) { create :plane }

  context 'validations' do
    it 'validates seat should be available' do
      plane.seats.each{ |s| s.update(occupied: true) }

      order = build :order, plane: plane
      expect(order).to be_invalid
    end
  end

  context 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:seat).optional }
    it { should belong_to(:plane) }
  end

  context 'callbacks' do
    let(:order) { create :order, plane: plane }

    it 'assign_seat' do
      expect(order.seat).to be_present
    end

    it 'mark_seat_as_occupied' do
      expect(order.seat.occupied).to be_truthy
    end
  end
end
