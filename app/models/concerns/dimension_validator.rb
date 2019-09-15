class DimensionValidator < ActiveModel::Validator
  def validate(record)
    @record = record

    begin
      @json_dimension = JSON.parse(@record.dimension)

      validates_array
      validates_empty_array
      validates_two_dimension_array
      validates_integer_value
      validates_greater_than_zero_value
    rescue
      @record.errors[:dimension] << 'Cannot process string as JSON'
    end
  end

  private def validates_array
    unless(@json_dimension.is_a?(Array))
      @record.errors[:dimension] << 'Should be array'
    end
  end

  private def validates_empty_array
    unless(@json_dimension.length > 0)
      @record.errors[:dimension] << 'Cannot be empty array'
    end
  end

  private def validates_two_dimension_array
    unless(@json_dimension.all? { |el| el.is_a?(Array) })
      @record.errors[:dimension] << 'All element should 2D array'
    end
  end

  private def validates_integer_value
    unless(@json_dimension.flatten.all? {|el| el.is_a? Integer})
      @record.errors[:dimension] << 'All element should Integer'
    end
  end

  private def validates_greater_than_zero_value
    unless(@json_dimension.flatten.all? {|el| el > 0})
      @record.errors[:dimension] << 'All element should greater than zero'
    end
  end
end
