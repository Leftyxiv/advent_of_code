require_relative '../../utils/griderator'

lines = File.readlines('2025/day7/input.txt').map(&:chomp)

grid = Griderator5000.new(lines)

##########
# Part 1 #
##########

def move_beam(grid, beam_locs, split_count)
  new_beam_locs = []
  beam_locs.each_with_index do |beam_loc, index|
    next if beam_loc == nil
    # puts "Beam loc: #{beam_loc[0]}, #{beam_loc[1]}, #{grid[beam_loc[0] + 1, beam_loc[1]]}"
    if grid[beam_loc[0] + 1, beam_loc[1]] == '.'
      grid[beam_loc[0] + 1, beam_loc[1]] = '|'
      beam_locs[index] = [beam_loc[0] + 1, beam_loc[1]]
    elsif grid[beam_loc[0] + 1, beam_loc[1]] == '^'
      beam_locs[index] = nil
      # puts "Beam hit a ^ at #{beam_loc[0]}, #{beam_loc[1]}"
      split_count += 1
      if grid[beam_loc[0] + 1, beam_loc[1]-1] == '.'
        new_beam_locs << [beam_loc[0] + 1, beam_loc[1]-1]
        grid[beam_loc[0] + 1, beam_loc[1]-1] = '|'
        # split_count += 1
        # puts "added a new beam loc at #{beam_loc[0] + 1}, #{beam_loc[1]-1}"
      end
      if grid[beam_loc[0] + 1, beam_loc[1]+1] == '.'
        new_beam_locs << [beam_loc[0] + 1, beam_loc[1]+1]
        grid[beam_loc[0] + 1, beam_loc[1]+1] = '|'
        # split_count += 1
        # puts "added a new beam loc at #{beam_loc[0] + 1}, #{beam_loc[1]+1}"
      end
    end
  end
  # puts "New beam locs: #{new_beam_locs.inspect}"
  [new_beam_locs, split_count]
end

part_one = 0
current_beam_locs = []
split_count = 0

starting_point = grid.find_location('S')
current_beam_locs << starting_point

(0..grid.height).each do |i|
  # puts "Iteration #{i}"
  # puts "Current beam locs: #{current_beam_locs.inspect}"
  new_beam_locs, split_count = move_beam(grid, current_beam_locs, split_count)
  current_beam_locs.concat(new_beam_locs)
end

part_one = split_count

puts "Part 1: #{part_one}"

##########
# Part 2 #
##########

grid = Griderator5000.new(lines)

def count_paths(grid, row, col, memo = {})
  return memo[[row, col]] if memo.key?([row, col])

  if row == grid.height - 1
    return 1
  end

  next_cell = grid[row + 1, col]

  result = if next_cell == '.'
    count_paths(grid, row + 1, col, memo)
  elsif next_cell == '^'
    left_paths = count_paths(grid, row + 1, col - 1, memo)
    right_paths = count_paths(grid, row + 1, col + 1, memo)
    left_paths + right_paths
  end

  memo[[row, col]] = result
  result
end

total_paths = count_paths(grid, starting_point[0], starting_point[1], {})
puts "Part 2: #{total_paths}"