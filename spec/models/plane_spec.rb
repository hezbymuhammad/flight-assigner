require 'rails_helper'

describe Plane, type: :model do
  let(:plane) { create :plane }

  context 'associations' do
    it { should have_many(:seats) }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:dimension) }

    it 'validate using DimensionValidator' do
      expect(plane).to validate_with DimensionValidator
    end

    it 'not validate using DimensionValidator if prototype' do
      plane = create :plane, prototype_only: true, dimension: '[]'

      expect(plane.valid?).to be_truthy
    end
  end

  context 'callbacks' do
    it 'assign seats' do
      expect(SeatsFactoryService).to receive_message_chain(:new, :run)

      create :plane
    end

    it 'not assign seats if prototype only' do
      expect(SeatsFactoryService).to_not receive(:new)

      create :plane, prototype_only: true, dimension: '[]'
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
