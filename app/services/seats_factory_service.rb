class SeatsFactoryService
  attr_accessor :plane

  def initialize(plane)
    @plane = plane
  end

  def run
    prepare
    assign_seats

    (@aisle_seats + @window_seats + @center_seats).each.with_index(1) do |seat, idx|
      seat.update_attributes(queue_number: idx)
    end
  end

  private def prepare
    @plane = clean_up(@plane)

    expand(@plane.parsed_dimension)

    @plane.reload
    @max_section = @plane.seats.maximum(:section_idx)
    @max_row = @plane.seats.maximum(:row_idx)

    @aisle_seats = []
    @window_seats = []
    @center_seats = []
  end

  private def assign_seats
    for row in 0..@max_row
      for sec in 0..@max_section
	max_section_row = @plane.seats.where(section_idx: sec).maximum(:row_idx)
	max_section_column = @plane.seats.where(section_idx: sec).maximum(:column_idx)

	next if row > max_section_row

	for col in 0..max_section_column
	  current_seat =  @plane.seats.find_by(section_idx: sec,
						column_idx: col,
						row_idx: row)

	  if is_aisle_seat?(sec, col, max_section_column)
	    @aisle_seats << current_seat
	  elsif is_window_seats?(sec, col, max_section_column)
	    @window_seats << current_seat
	  else
	    @center_seats << current_seat
	  end
	end
      end
    end
  end

  private def is_aisle_seat?(sec, col, max_section_column)
    return unless col == 0 || col == max_section_column
    return if col == 0 && sec == 0
    return if col == max_section_column && sec == @max_section

    true
  end

  private def is_window_seats?(sec, col, max_section_column)
    return true if sec == 0 && col == 0
    return true if sec == @max_section && col == max_section_column

    false
  end

  private def expand(parsed_dimension)
    [].tap do |arr|
      parsed_dimension.each_with_index do |v, k|
	arr << (1..v[1]).map.with_index do |_, kk|
	  Array.new(v[0]) do |kkk|
	    Seat.find_or_create_by(section_idx: arr.length,
				   column_idx: kk,
				   row_idx: kkk,
				   plane: @plane)
	  end
	end
      end
    end
  end

  private def clean_up(plane)
    plane.tap{ |v| v.seats.destroy_all }
  end
end
