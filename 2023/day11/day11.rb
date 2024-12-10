lines = File.readlines('sample.txt').map(&:chomp)

def get_horizontal_lines(lines)
  lines_to_dup = []
  lines.each_with_index do |thingy, i|
    if !thingy.include?('#')
      lines_to_dup << i
    end
  end
  lines_to_dup
end

def get_vertical_lines(lines)
  lines_to_dup = []
  lines.each_with_index do |thingy, i|
    chars = ''
    (0..lines.length - 1).each do |j|
      chars += lines[j][i]
    end
    if !chars.include?('#')
      lines_to_dup << i
    end
  end
  lines_to_dup
end

vertical_lines_to_duplicate = get_vertical_lines(lines)
horizontal_lines_to_duplicate = get_horizontal_lines(lines)


get_horizontal_lines(lines)
get_vertical_lines(lines)

def add_horizontal_lines(lines, lines_to_dup)
  lines_to_dup.each do |line|
    lines.insert(line + 1, '.' * lines[0].length)
  end
end

def add_vertical_lines(lines, lines_to_dup)
  lines_to_dup.reverse.each do |line|
    lines.each do |row|
      row.insert(line, '.')
    end
  end
end

add_horizontal_lines(lines, horizontal_lines_to_duplicate)
add_vertical_lines(lines, vertical_lines_to_duplicate)


lines.map! do |line|
  line.split('')
end

galaxy_locations = []
galaxy_number = 0

lines.each_with_index do |line, i|
  line.each_with_index do |char, j|
    if char == '#'
      galaxy_locations[galaxy_number] ||= []
      galaxy_locations[galaxy_number] << [i, j]
      galaxy_number += 1
    end
  end
end

galaxy_distances = []


def distance(point1, point2)
  (point1[0] - point2[0]).abs + (point1[1] - point2[1]).abs
end


already_added_coords = {}

galaxy_locations.each_with_index do |galaxy, i|
  galaxy_distances[i] ||= []
  (0..galaxy_locations.length - 1).each do |j|
    next if galaxy[0][0] == galaxy_locations[j][0][0] && galaxy[0][1] == galaxy_locations[j][0][1]
    next if already_added_coords["#{galaxy[0]}-#{galaxy_locations[j][0]}"] == true
    next if already_added_coords["#{galaxy_locations[j][0]}-#{galaxy[0]}"] == true

    already_added_coords["#{galaxy[0]}-#{galaxy_locations[j][0]}"] ||= true
    distance = distance(galaxy[0], galaxy_locations[j][0])
    galaxy_distances[i] << distance
  end
end

skips = 0
numbers = 0
galaxy_distances.each_with_index do |galaxy, i|
  galaxy.each do |distance|
    skips += distance
  end
end

puts skips
