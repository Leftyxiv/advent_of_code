require_relative '../../utils/griderator'
require 'set'
lines = File.readlines("2024/day20/input.txt", chomp: true)

grid = Griderator5000.new(lines)


def cheater_cheater_pumpkin_eater(grid_obj, steps_S, steps_E, end_position, saving_threshold)
  rows = grid_obj.grid.size
  cols = grid_obj.grid[0].size
  directions = [[-1,0], [1,0], [0,-1], [0,1]]
  cheats_found = Set.new
  cheat_count = 0
  end_x, end_y = end_position
  steps_S_E = steps_S[end_x][end_y]

  (0...rows).each do |x|
    (0...cols).each do |y|
      next unless grid_obj[x, y] == '.'

      directions.each do |dx1, dy1|
        nx1, ny1 = x + dx1, y + dy1

        next unless grid_obj.in_bounds?(nx1, ny1) && grid_obj[nx1, ny1] == '#'

        directions.each do |dx2, dy2|
          nx2, ny2 = nx1 + dx2, ny1 + dy2

          next unless grid_obj.in_bounds?(nx2, ny2) && grid_obj[nx2, ny2] == '.'

          next if steps_S[x][y] == Float::INFINITY || steps_E[nx2][ny2] == Float::INFINITY

          saving = steps_S_E - (steps_S[x][y] + 2 + steps_E[nx2][ny2])

          if saving >= saving_threshold
            cheat_id = [[x, y], [nx2, ny2]]
            unless cheats_found.include?(cheat_id)
              cheats_found.add(cheat_id)
              cheat_count += 1
            end
          end
        end
      end
    end
  end

  cheat_count
end

##########
# Part 1 #
##########

grid_obj = Griderator5000.new(lines)

start_pos = grid_obj.find_location('S')
end_pos = grid_obj.find_location('E')

steps_from_start = grid_obj.bfs(start_pos[0], start_pos[1])
steps_from_end = grid_obj.bfs(end_pos[0], end_pos[1])
grid_obj[start_pos[0], start_pos[1]] = '.'
grid_obj[end_pos[0], end_pos[1]] = '.'
saving_threshold = 100

number_of_cheats = cheater_cheater_pumpkin_eater(grid_obj, steps_from_start, steps_from_end, end_pos, saving_threshold)

puts "Part 1: #{number_of_cheats}"

##########
# Part 2 #
##########

def super_cheaters(grid, start_row, start_col, max_steps = 20)
  steps = Array.new(grid.height) { Array.new(grid.width, Float::INFINITY) }

  queue = []

  steps[start_row][start_col] = 0
  queue << [start_row, start_col, 0]

  until queue.empty?
    current = queue.shift
    current_row, current_col, current_steps = current

    next if current_steps >= max_steps

    grid.get_homies(current_row, current_col).each do |neighbor_row, neighbor_col|
      if steps[neighbor_row][neighbor_col] > current_steps + 1
        steps[neighbor_row][neighbor_col] = current_steps + 1
        queue << [neighbor_row, neighbor_col, current_steps + 1]
      end
    end
  end

  steps
end

def stop_cheating_cheaters(grid_obj, steps_S, steps_E, end_position, saving_threshold)
  rows = grid_obj.height
  cols = grid_obj.width
  cheats_found = Set.new
  cheat_count = 0
  end_x, end_y = end_position
  steps_S_E = steps_S[end_x][end_y]

  grid_obj.each_cell do |x, y, cell|
    next unless cell == '.'

    steps_cheat = super_cheaters(grid_obj, x, y, 20)

    (0...rows).each do |bx|
      (0...cols).each do |by|
        next unless grid_obj[bx, by] == '.'

        k = steps_cheat[bx][by]
        next if k == Float::INFINITY 
        next if k < 1 || k > 20

        saving = steps_S_E - (steps_S[x][y] + k + steps_E[bx][by])

        if saving >= saving_threshold
          cheat_id = [[x, y], [bx, by]]
          unless cheats_found.include?(cheat_id)
            cheats_found.add(cheat_id)
            cheat_count += 1
          end
        end
      end
    end
  end

  cheat_count
end
puts "Part 2: #{stop_cheating_cheaters(grid_obj, steps_from_start, steps_from_end, end_pos, 100)}"
