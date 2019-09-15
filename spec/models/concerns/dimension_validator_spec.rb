require 'rails_helper'

class Validatable
  include ActiveModel::Validations
  validates_with DimensionValidator
  attr_accessor  :dimension
end

describe DimensionValidator do
  let(:record) { Validatable.new }

  it 'should parseable' do
    record.dimension = 'asd'

    expect(record).to be_invalid
  end

  it 'should be array' do
    record.dimension = '{}'

    expect(record).to be_invalid
  end

  it 'cannot empty array' do
    record.dimension = '[]'

    expect(record).to be_invalid
  end

  it 'should consist of 2Ds array' do
    record.dimension = '[1, 2]'

    expect(record).to be_invalid
  end

  it 'all 2D array element type should integer' do
    record.dimension = '[["a", 1]]'

    expect(record).to be_invalid
  end

  it 'should not contains zero' do
    record.dimension = '[[1, 0]]'

    expect(record).to be_invalid
  end

  it 'should not contains negative' do
    record.dimension = '[[1, 0]]'

    expect(record).to be_invalid
  end

  it 'all valid' do
    record.dimension = '[[1, 2]]'

    expect(record).to be_valid
  end
end

