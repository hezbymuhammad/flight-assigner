require 'rails_helper'

describe Plane, type: :model do
  let(:plane) { create :plane }

  context 'associations' do
    it { should have_many(:seats) }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:dimension) }
  end

  context 'callbacks' do
    it 'assign seats' do
      expect(SeatsFactoryService).to receive_message_chain(:new, :run)

      create :plane
    end
  end

  describe '#available_seat' do
    let!(:unoccupied_seat) { create :seat, plane: plane, occupied: false }

    before { create_list :seat, 2, plane: plane, occupied: true }

    it 'return first queued unoccupied seat' do
      expect(plane.available_seat).to eq(unoccupied_seat)
    end
  end

  describe '#parsed_dimension' do
    it 'JSON data type' do
      expect(plane.parsed_dimension.is_a?(Array))
    end
  end
end
