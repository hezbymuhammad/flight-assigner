namespace :simulation do
  desc 'Simulation to comply with test'
  task queue: :environment do
    puts "Generating plane model"
    plane = FactoryBot.create(:plane, dimension: '[[2,3], [3,4], [3,2], [4,3]]')
    puts "Plane created: #{plane.name}"
    puts ""
    puts ""
    puts "Now queuing 30 users"
    puts ""
    puts ""
    30.times do |i|
      username = FFaker::Internet.user_name
      email = FFaker::Internet.email
      user = FactoryBot.create(:user, username: "#{username}#{i}", email: "#{email}#{i}")
      puts "Created user: #{user.username}"
      order = user.orders.create(plane: plane)
      puts "User queued on seat number #{order.seat.code}"
      puts ""
    end

    plane.reload
    max_section = plane.seats.maximum(:section_idx)
    max_row = plane.seats.maximum(:row_idx)

    puts "red is occupied seat".colorize(:red)
    puts "green is available seat".colorize(:green)
    puts ""

    for row in 0..max_row
      for sec in 0..max_section
	max_section_row = plane.seats.where(section_idx: sec).maximum(:row_idx)
	max_section_column = plane.seats.where(section_idx: sec).maximum(:column_idx)

	if row > max_section_row
	  (max_section_column + 1).times do
	    print 'xx '
	  end
	  print ' '
	  next
	end

	for col in 0..max_section_column
	  current_seat =  plane.seats.find_by(section_idx: sec,
				              column_idx: col,
					      row_idx: row)

	  color = current_seat.occupied? ? :red : :green

	  str = "%.2i" %current_seat.queue_number
	  print str.colorize(color)
	  print ' '
	end

	print ' '
      end
      print "\n"
    end

    puts ""
  end
end

