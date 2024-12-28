require_relative '../../utils/griderator'
inputs = File.read('2015/day6/input.txt').split("\n")
light_matcher = /(\d+),(\d+) through (\d+),(\d+)/
grid = Griderator5000.new(rows: 1000, cols: 1000, default_value: 'X')

inputs.each do |input|
  toggles = []
  x1, y1, x2, y2 = input.scan(light_matcher).flatten.map(&:to_i)
  if input.include?('on')
    grid.fill(x1..x2, y1..y2, 'O')
  elsif input.include?('off')
    grid.fill(x1..x2, y1..y2, 'X')
  else
    grid.each_cell do |row, col, light|
      if row >= x1 && row <= x2 && col >= y1 && col <= y2
        toggles << [row, col]
      end
    end
    toggles.each do |toggle|
      row, col = toggle
      grid[row, col] = grid[row, col] == 'O' ? 'X' : 'O'
    end
  end
end
lights = grid.find_all_locations('O').count
puts "Lights: #{lights}"

new_grid = Griderator5000.new(rows: 1000, cols: 1000, default_value: 0)

inputs.each do |input|
  toggles = []
  x1, y1, x2, y2 = input.scan(light_matcher).flatten.map(&:to_i)
  new_grid.each_cell do |row, col, light|
    if row >= x1 && row <= x2 && col >= y1 && col <= y2
      toggles << [row, col]
    end
  end
  if input.include?('on')
    toggles.each do |toggle|
      row, col = toggle
      new_grid[row, col] += 1
    end
  elsif input.include?('off')
    toggles.each do |toggle|
      row, col = toggle
      new_grid[row, col] -= 1 if new_grid[row, col] > 0
    end
  else
    toggles.each do |toggle|
      row, col = toggle
      new_grid[row, col] += 2
    end
  end
end

light_brightness = 0
new_grid.each_cell do |row, col, val|
  light_brightness += val
end

puts "Light Brightness: #{light_brightness}"