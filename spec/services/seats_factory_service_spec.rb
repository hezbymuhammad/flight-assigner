require 'rails_helper'

describe SeatsFactoryService do
  let(:plane) { create :plane, dimension: '[[1, 2], [2,2]]' }
  let(:service) { SeatsFactoryService.new(plane) }

  describe '.new' do
    it 'set plane' do
      expect(service.plane).to eq(plane)
    end
  end

  describe '#run' do
    it 'set skeleton seats' do
      service.run

      expect(Seat.all.map(&:section_idx)).to eq([0, 0, 1, 1, 1, 1])
      expect(Seat.all.map(&:column_idx)).to eq([0, 1, 0, 0, 1, 1])
      expect(Seat.all.map(&:row_idx)).to eq([0, 0, 0, 1, 0, 1])
    end

    it 'clean up seats' do
      create_list :seat, 2, plane: plane

      # Only run clean up
      allow(service).to receive(:expand)
      allow(service).to receive(:assign_seats)

      service.run

      expect(plane.reload.seats).to be_empty
    end

    it 'assign queue_number to seats' do
      service.run

      # The format for seat code is "<section><column>-<row>"
      expect(Seat.queued.map(&:code)).to eq(['01-0', '10-0', '10-1', '00-0', '11-0', '11-1'])
    end
  end
end
