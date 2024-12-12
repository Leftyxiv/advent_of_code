require_relative '../../utils/griderator'
require 'set'

lines = File.read('2024/day12/input.txt').split("\n")

grid = Griderator5000.new(lines)

def find_connected_components(grid)
  visited = Array.new(grid.height) { Array.new(grid.width, false) }
  components = []

  grid.each_cell do |row, col, cell|
    next if visited[row][col]

    stack = [[row, col]]
    component = []

    while stack.any?
      x, y = stack.pop
      next if visited[x][y]

      visited[x][y] = true
      component << [x, y]

      grid.get_homies(x, y).each do |nx, ny|
        if !visited[nx][ny] && grid[nx,ny] == cell
          stack.push([nx, ny])
        end
      end
    end

    components << [cell, component]
  end

  components
end

plant_plots = Hash.new { |hash, key| hash[key] = [] }

find_connected_components(grid).each do |cell_value, component|
  plant_plots[cell_value] << component
end

def count_fence_places(grid, plant, locations)
  count = 0
  locations.each do |location|
    homies = grid.get_homies(location[0], location[1])
    the_difference = locations.select { |loc| homies.include?(loc) }
    count += 4 - the_difference.size
  end
  count * locations.size
end

############
# Part One #
############

part_one = 0

plant_plots.each do |plant, plots|
  plots.each do |locations|
    part_one += count_fence_places(grid, plant, locations)
  end
end

puts "Part 1: #{part_one}"

############
# Part Two #
############

def even_more_crap(arr)
  return 0 if arr.length < 1
  count = 1
  (0...arr.length - 1).each do |i|
    count += 1 if (arr[i] - arr[i + 1]).abs != 1
  end
  count
end

def im_so_over_this(grid, plant, locations)
  sides = {
    up: [],
    down: [],
    left: [],
    right: []
  }
  locations.each do |location|
    plot_above = [location[0] - 1, location[1]]
    plot_below = [location[0] + 1, location[1]]
    plot_left = [location[0], location[1] - 1]
    plot_right = [location[0], location[1] + 1]
    if !locations.include?(plot_above) #&& !locations.include?(plot_left) || !locations.include?(plot_above) # !locations.include?(plot_right)
      sides[:up] << location
    end
    if !locations.include?(plot_below) #&& !locations.include?(plot_left) || !locations.include?(plot_below) && !locations.include?(plot_right)
      sides[:down] << location
    end
    if !locations.include?(plot_left) #&& !locations.include?(plot_above) || !locations.include?(plot_left) && !locations.include?(plot_below)
      sides[:left] << location
    end
    if !locations.include?(plot_right) #&& !locations.include?(plot_above) || !locations.include?(plot_right) && !locations.include?(plot_below)
      sides[:right] << location
    end
  end
  count = 0
  not_loop_count = 0
  row_mapped_top_locations = Hash.new { |h, k| h[k] = [] }
  row_mapped_bottom_locations = Hash.new { |h, k| h[k] = [] }
  col_mapped_left_locations = Hash.new { |h, k| h[k] = [] }
  col_mapped_right_locations = Hash.new { |h, k| h[k] = [] }
  sides[:up].each do |loc|
    row_mapped_top_locations[loc[0]] << loc[1]
  end
  sides[:down].each do |loc|
    row_mapped_bottom_locations[loc[0]] << loc[1]
  end
  sides[:left].each do |loc|
    col_mapped_left_locations[loc[1]] << loc[0]
  end
  sides[:right].each do |loc|
    col_mapped_right_locations[loc[1]] << loc[0]
  end
  row_mapped_top_locations.each do |row, cols|
    # puts "Plant#{plant} #{row} #{cols}"
    not_loop_count += even_more_crap(cols.sort)
  end
  row_mapped_bottom_locations.each do |row, cols|
    # puts "Plant#{plant} #{row} #{cols}"
    not_loop_count += even_more_crap(cols.sort)
  end
  col_mapped_left_locations.each do |col, rows|
    # puts "Plant#{plant} #{rows} #{col}"
    not_loop_count += even_more_crap(rows.sort)
  end
  col_mapped_right_locations.each do |col, rows|
    # puts "Plant#{plant} #{rows} #{col}"
    not_loop_count += even_more_crap(rows.sort)
  end
  # return 4 * locations.size if sides[:up].size == 1 || sides[:down].size == 1 || sides[:left].size == 1 || sides[:right].size == 1
  #left_edge_cols = left_edge_cols = sides[:left].sort_by { |loc| loc[0] }.map { |loc| loc[1] }#.uniq
  # right_edge_cols = sides[:right].sort_by { |loc| loc[0] }.map { |loc| loc[1] }#.uniq
  # top_edge_rows = sides[:up].sort_by { |loc| loc[1] }.map { |loc| loc[0] }#.uniq
  # bottom_edge_rows = sides[:down].sort_by { |loc| loc[1] }.map { |loc| loc[0] }#.uniq
  # puts "Plant#{plant} #{left_edge_cols.inspect}"
  # puts "Plant#{plant} #{right_edge_cols.inspect}"
  # puts "Plant#{plant} #{top_edge_rows.inspect}"
  # puts "Plant#{plant} #{bottom_edge_rows.inspect}"
  # sides.each do |side, loc|
  #   count += 1
  #   x, y = loc[0]
  #   loc.each do |l|
  #     if side == :up
  #       if l[0] != x
  #         count += 1
  #         x = l[0]
  #       end
  #     elsif side == :down
  #       if l[0] != x
  #         count += 1
  #         x = l[0]
  #       end
  #     elsif side == :left
  #       if l[1] != y
  #       count += 1
  #       y = l[1]
  #       end
  #     elsif side == :right
  #       if l[1] != y
  #       count += 1
  #       y = l[1]
  #       end
  #     end
  #   end
  # end
  not_loop_count * locations.size
end

part_two = 0

plant_plots.each do |plant, locations|
  locations.each do |location|
    part_two += im_so_over_this(grid, plant, location)
  end
end

puts "Part 2: #{part_two}"
# def count_fence_places_with_sides(grid, plant, locations)
#   unique_sides = Set.new

#   locations.each do |x, y|
#     neighbors = grid.get_homies(x, y)

#     # Considering the 4 possible directions: up, down, left, right
#     [[x-1, y], [x+1, y], [x, y-1], [x, y+1]].each do |nx, ny|
#       if !neighbors.include?([nx, ny]) || grid[nx, ny] != plant
#         unique_sides.add([[x, y], [nx, ny]].sort)
#       end
#     end
#   end

#   return locations.size * unique_sides.size
# end

# part_two = 0

# plant_plots.each do |plant, plots|
#   plots.each do |locations|
#     part_two += count_fence_places_with_sides(grid, plant, locations)
#   end
# end

# puts "Part 2: #{part_two}"

# def even_more_crap(arr)
#   return 0 if arr.length < 1
#   count = 1  # Start with 1 because the beginning boundary itself counts
#   (1...arr.length - 1).each do |i|
#     count += 1 if arr[i] != arr[i + 1]
#   end
#   count
# end
# not_loop_count += even_more_crap(left_edge_cols)
#   not_loop_count += even_more_crap(right_edge_cols)
#   not_loop_count += even_more_crap(top_edge_rows)
#   not_loop_count += even_more_crap(bottom_edge_rows)

# left_edge_cols = sides[:left].sort do |locA, locB|
#   # First compare by the first element
#   result = locA[0] <=> locB[0]
#   # If they are the same, compare by the second element
#   result.zero? ? locA[1] <=> locB[1] : result
# end.map { |loc| loc[1] }
# right_edge_cols = sides[:right].sort do |locA, locB|
#   result = locA[0] <=> locB[0]
#   result.zero? ? locA[1] <=> locB[1] : result
# end.map { |loc| loc[1] }
# top_edge_rows = sides[:up].sort do |locA, locB|
#   result = locA[1] <=> locB[1]
#   result.zero? ? locA[0] <=> locB[0] : result
# end.map { |loc| loc[0] }
# bottom_edge_rows = sides[:down].sort do |locA, locB|
#   result = locA[1] <=> locB[1]
#   result.zero? ? locA[0] <=> locB[0] : result
# end.map { |loc| loc[0] }