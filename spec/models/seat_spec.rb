require 'rails_helper'

describe Seat, type: :model do
  let(:seat) { create :seat, occupied: false }

  context 'associations' do
    it { should belong_to(:plane) }
  end

  describe '.unoccupied' do
    let(:unoccupied_seats) { create_list :seat, 2, occupied: false }

    before { create_list :seat, 2, occupied: true }

    it 'return unoccupied seats' do
      expect(Seat.unoccupied).to eq(unoccupied_seats)
    end
  end

  describe '.occupied' do
    let(:occupied_seats) { create_list :seat, 2, occupied: true }

    before { create_list :seat, 2, occupied: false }

    it 'return unoccupied seats' do
      expect(Seat.occupied).to eq(occupied_seats)
    end
  end

  describe '.queued' do
    let(:seats) { create_list :seat, 2 }

    it 'order based on queue_number' do
      expect(Seat.queued).to eq(seats.sort.sort{|a,b| a.queue_number <=> b.queue_number })
    end
  end

  describe '#mark_as_occupied!' do
    it 'update occupied to true' do
      seat.mark_as_occupied!

      expect(seat.reload.occupied).to be_truthy
    end
  end
end
