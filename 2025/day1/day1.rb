times_is_0_step_1 = 0

def turn_dial_left(current_position, spaces)
  if spaces > 100
    while spaces > 100
      spaces -= 100
    end
  end
  if spaces > current_position
    left_over = spaces - current_position
    (100 - left_over)
  else
    (current_position - spaces)
  end
end

def turn_dial_right(current_position, spaces)
  if spaces > 100
    while spaces > 100
      spaces -= 100
    end
  end
  if spaces + current_position >= 100
    left_over = spaces + current_position - 100
    left_over
  else
    spaces + current_position
  end
end

lines = File.read('2025/day1/input.txt').split("\n")

position = 50
lines.each do |line|
  if line.start_with?('L')
    position = turn_dial_left(position, line.split('')[1..-1].join.to_i)
    times_is_0_step_1 += 1 if position == 0
  else
    position = turn_dial_right(position, line.split('')[1..-1].join.to_i)
    times_is_0_step_1 += 1 if position == 0
  end
end

puts "step 1: #{times_is_0_step_1}"

##########
# Part 2 #
##########

times_is_0_step_2 = 0

def left_step_two(current_position, spaces, times_is_0_step_2)
  if spaces > 100
    while spaces > 100
      spaces -= 100
      times_is_0_step_2 += 1
    end
  end
  if spaces > current_position
    left_over = spaces - current_position
    times_is_0_step_2 += 1 unless (left_over == 0 || current_position == 0)
    # puts [(100 - left_over), times_is_0_step_2].inspect
    return [(100 - left_over), times_is_0_step_2]
  else
    # puts [(current_position - spaces), times_is_0_step_2].inspect
    [(current_position - spaces), times_is_0_step_2]
    return [(current_position - spaces), times_is_0_step_2]
  end
end

def right_step_two(current_position, spaces, times_is_0_step_2)
  if spaces > 100
    while spaces > 100
      spaces -= 100
      times_is_0_step_2 += 1
    end
  end
  if spaces + current_position >= 100
    # puts "left_over: #{spaces + current_position - 100}"
    left_over = spaces + current_position - 100
    times_is_0_step_2 += 1 unless left_over == 0
    # puts [left_over, times_is_0_step_2].inspect
    return [left_over, times_is_0_step_2]
  else
    # puts [spaces + current_position, times_is_0_step_2].inspect
    return [spaces + current_position, times_is_0_step_2]
  end
end

position = 50
lines.each do |line|
  if line.start_with?('L')
    position, times_is_0_step_2 = left_step_two(position, line.split('')[1..-1].join.to_i, times_is_0_step_2)
    times_is_0_step_2 += 1 if position == 0
    # puts "position: #{position}, times_is_0_step_2: #{times_is_0_step_2}" if position == 0
  else
    position, times_is_0_step_2 = right_step_two(position, line.split('')[1..-1].join.to_i, times_is_0_step_2)
    times_is_0_step_2 += 1 if position == 0
    # puts "position: #{position}, times_is_0_step_2: #{times_is_0_step_2}" if position == 0
  end
end

puts "step 2: #{times_is_0_step_2}"