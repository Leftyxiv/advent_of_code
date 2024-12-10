lines = File.readlines('input.txt').map(&:chomp)

turns = lines[0].split('')
map_coords = []

(2..lines.length-1).each do |i|
  key, value = lines[i].split(' = ')
  value = value.gsub('(','').gsub(')','')
  value1, value2 = value.split(', ')
  map_coords << [key, value1, value2]
end

# current_coords = "AAA"
current_coords = []
coords_obj = {}

map_coords.each do |coord|
  if coord[0].end_with?('A')
    current_coords << coord[0]
  end
end

map_coords.each do |coord|
  coords_obj[coord[0]] = [coord[1], coord[2]]
end


step_counts = []

current_coords.each_with_index do |coord, ii|
  steps = 0
  while !current_coords[ii].end_with?('Z')
    left_or_right = turns[steps % turns.length] == 'L' ? 0 : 1
    steps += 1
    current_coords[ii] = coords_obj[current_coords[ii]][left_or_right]
    if current_coords[ii].end_with?('Z')
      step_counts << steps
    end
  end
end

puts step_counts.inspect
puts step_counts.reduce(1, :lcm)

# while !current_coords.map { |c| c.end_with?('Z') }.all?
#   left_or_right = turns[steps % turns.length] == 'L' ? 0 : 1
#   current_coords.each_with_index do |coord, ii|
#     current_coords[ii] = coords_obj[coord][left_or_right]
#   end
#   steps += 1
#   # puts steps / 100_000 if steps % 100_000 == 0
#   # puts current_coords.inspect if steps % 100_000 == 0
# end
# while !current_coords.map { |c| c.end_with?('Z') }.all?
# left_or_right = turns[steps % turns.length] == 'L' ? 1 : 2
# current_coords.each_with_index do |coord, ii|
#   (0..map_coords.length-1).each do |i|
#       if map_coords[i][0] == coord
#         current_coords[ii] = map_coords[i][left_or_right]
#         break
#       end
#     end
#   end
#   steps += 1
# end

# while current_coords != 'ZZZ'
#   left_or_right = turns[steps % turns.length] == 'L' ? 1 : 2
#   (0..map_coords.length-1).each do |i|
#     if map_coords[i][0] == current_coords
#       current_coords = map_coords[i][left_or_right]
#       break
#     end
#   end
#   steps += 1
# end

# puts steps