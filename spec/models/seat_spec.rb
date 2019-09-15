require 'rails_helper'

describe Seat, type: :model do
  let(:seats) { create_list :seat, 2 }

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

  describe '.queued' do
    it 'order based on queue_number' do
      expect(Seat.queued).to eq(seats.sort.sort{|a,b| a.queue_number <=> b.queue_number })
    end
  end
end
