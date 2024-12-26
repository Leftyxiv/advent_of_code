require_relative '../../utils/griderator'
lines = File.read('2024/day25/input.txt').split("\n\n")

keys = Hash.new { |h, k| h[k] = [] }
locks = Hash.new { |h, k| h[k] = [] }
grid_height = 0
lines.each_with_index do |line, i|
  section = line.split("\n")
  grid = Griderator5000.new(section)
  aggregator = Hash.new { |h, k| h[k] = [] }
  if section[0].include?('#')
    lock_pins = grid.find_all_locations('#')
    lock_pins.each do |pin|
      aggregator[pin[1]] << pin[0]
    end
    grid_height = grid.height
    aggregator.each do |k, v|
      locks[i] << v.max
    end
  else
    key_pins = grid.find_all_locations('#')
    key_pins.each do |pin|
      aggregator[pin[1]] << grid.height - 1 - pin[0]
    end
    (0..aggregator.keys.max).each do |k|
      next unless aggregator[k]
      keys[i] << aggregator[k].max
    end
  end
end

##########
# part 1 #
##########
part_one = 0

keys.each do |k, v|
  locks.each do |l, w|
    every = true
    w.each_with_index do |lock, i|
      if v[i] + w[i] >= grid_height - 1
        every = false
        break
      end
    end
    part_one += 1 if every
  end
end
puts "Part 1: #{part_one}"