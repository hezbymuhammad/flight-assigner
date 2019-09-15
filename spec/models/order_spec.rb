require 'rails_helper'

describe Order, type: :model do
  context 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:seat) }
    it { should belong_to(:plane) }
  end
end
