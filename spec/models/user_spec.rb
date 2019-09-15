require 'rails_helper'

describe User, type: :model do
  context 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:username) }
  end

  context 'associations' do
    it { should have_many(:orders) }
  end
end
