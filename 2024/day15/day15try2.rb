require_relative '../../utils/griderator'
top, bottom = File.read("2024/day15/sample3.txt").split("\n\n")

grid = Griderator5000.new(top.split("\n"))
moves = bottom.split("\n").join('')

r, c = grid.find_location('@')

moves.each_char do |move|
  dr = move == '^' ? -1 : move == 'v' ? 1 : 0
  dc = move == '<' ? -1 : move == '>' ? 1 : 0
  targets = [[r, c]]
  cr, cc = r, c
  go = true

  while true
    cr += dr
    cc += dc
    char = grid[cr, cc]

    if char == '#'
      go = false
      break
    end

    if char == 'O'
      targets << [cr, cc]
    end

    if char == '.'
      break
    end
  end

  if go
    grid[r, c] = '.'  
    grid[r + dr, c + dc] = '@'

    (1..targets.length - 1).each do |i|
      grid[targets[i][0] + dr, targets[i][1] + dc] = 'O'
    end

    r += dr
    c += dc
  end
end

part_one = 0
boxes = grid.find_all_locations('O')
boxes.each do |box|
  part_one += 100 * box[0] + box[1]
end
puts "Part 1: #{part_one}"

wider_map = []
top.split("\n").each do |row|
  new_row = ''
  row.each_char do |char|
    if char == '#'
      new_row += '##'
    elsif char == '.'
    new_row += '..'
    elsif char == 'O'
      new_row += '[]'
    elsif char == '@'
      new_row += '@.'
    end
  end
  wider_map << new_row
end

fat_grid = Griderator5000.new(wider_map)
fat_grid.grid_me

r, c = fat_grid.find_location('@')

# moves.each_char do |move|
#   dr = move == '^' ? -1 : move == 'v' ? 1 : 0
#   dc = move == '<' ? -1 : move == '>' ? 1 : 0
#   targets = [[r, c]]
#   cr, cc = r, c
#   go = true
#   puts targets.inspect
  # targets.each do |cr, cc|
  #   nr = cr + dr
  #   nc = cc + dc
  #   next if targets.include?([nr, nc])
  #   char = fat_grid[nr, nc]

  #   if char == '#'
  #     go = false
  #     break
  #   end

  #   if char == '['
  #     targets << [cr, cc]
  #     targets << [nr, nc + 1]
  #   end

  #   if char == ']'
  #     targets << [cr, cc]
  #     targets << [nr, nc - 1]
  #   end

  #   if char == 'O'
  #     targets << [cr, cc]
  #   end
  # end
  # grid_clone = fat_grid.shallow_copy
  # grid_clone.grid_me
  # break
  # if go
  #   fat_grid[r, c] = '.'  
  #   fat_grid[r + dr, c + dc] = '@'

  #   (1..targets.length - 1).each do |i|
  #     fat_grid[targets[i][0], targets[i][1]] = '.'
  #   end
  #   (1..targets.length - 1).each do |i|
  #     fat_grid[targets[i][0] + dr, targets[i][1] + dc] = grid_clone[targets[i][0], targets[i][1]]
  #   end

  #   r += dr
  #   c += dc
  # end
# end
moves.each_char do |move|
  dr = case move
       when '^' then -1
       when 'v' then 1
       else 0
       end
  dc = case move
       when '<' then -1
       when '>' then 1
       else 0
       end

  target_r = r + dr
  target_c = c + dc

  # Check grid boundaries to prevent out-of-bounds errors
  if target_r < 0 || target_r >= fat_grid.grid.size || target_c < 0 || target_c >= fat_grid.grid[0].size
    next  # Move is out of grid, skip
  end

  target_char = fat_grid[target_r, target_c]

  if target_char == '#'
    # Movement blocked by a wall
    next
  elsif target_char == '[' || target_char == ']'
    # Identify the start of the box
    if target_char == '['
      box_start_r = target_r
      box_start_c = target_c
    else  # target_char == ']'
      box_start_r = target_r
      box_start_c = target_c - 1  # The '[' is to the left of ']'
      # Ensure that the '[' exists
      unless fat_grid[box_start_r, box_start_c] == '['
        next  # Malformed box, skip
      end
    end

    # Verify that the box is well-formed
    box_end_char = fat_grid[box_start_r, box_start_c + 1]
    unless box_end_char == ']'
      # Malformed box, cannot push
      next
    end

    # Determine new positions for the box
    new_box_start_r = box_start_r + dr
    new_box_start_c = box_start_c + dc
    new_box_end_r = new_box_start_r
    new_box_end_c = new_box_start_c + 1

    # Check grid boundaries for box movement
    if new_box_start_r < 0 || new_box_start_r >= fat_grid.grid.size ||
       new_box_start_c < 0 || new_box_end_c >= fat_grid.grid[0].size
      # Cannot push box out of grid
      next
    end

    # Check if the destination cells are empty
    destination_char1 = fat_grid[new_box_start_r, new_box_start_c]
    destination_char2 = fat_grid[new_box_end_r, new_box_end_c]

    if destination_char1 == '.' && destination_char2 == '.'
      # Push the box
      fat_grid[box_start_r, box_start_c] = '.'       # Clear '['
      fat_grid[box_start_r, box_start_c + 1] = '.'   # Clear ']'

      fat_grid[new_box_start_r, new_box_start_c] = '['  # Place new '['
      fat_grid[new_box_end_r, new_box_end_c] = ']'      # Place new ']'

      # Move the robot
      fat_grid[r, c] = '.'                    # Clear old robot position
      fat_grid[box_start_r, box_start_c] = '@' # Set new robot position

      # Update robot's position
      r = box_start_r
      c = box_start_c
    else
      # Cannot push the box; blocked by another box or wall
      next
    end
  elsif target_char == '.'
    # Move the robot to the empty space
    fat_grid[r, c] = '.'           # Clear old robot position
    fat_grid[target_r, target_c] = '@' # Set new robot position

    # Update robot's position
    r = target_r
    c = target_c
  else
    # Encountered an unexpected character; skip the move
    next
  end
end

fat_grid.grid_me
