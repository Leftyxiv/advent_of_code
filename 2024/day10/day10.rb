require_relative '../../utils/griderator'

lines = File.read('2024/day10/input.txt').split("\n")

grid = Griderator5000.new(lines)

ground_level_locations = grid.find_all_locations('0')
stepped_on_9s = {}

def get_lifted(where_i_am, grid, first_spot, stepped_on_9s)
  x, y = where_i_am
  # UNCOMMENT FOR PART 1
  # if grid[x, y].to_i == 9
  #   key = "#{first_spot}-#{[x, y]}"
  #   return 0 if stepped_on_9s[key] == true
  #   stepped_on_9s[key] = true
  #   return 1
  # end
  ### PART 2 VVVVVV ###
  return 1 if grid[x, y].to_i == 9
  ### PART 2 ^^^^^^ ###

  score = 0
  homies = grid.get_homies(x, y, diagonals: false)
  homies.each do |homiex, homiey|
    if grid[homiex, homiey].to_i - grid[x, y].to_i == 1
      score += get_lifted([homiex, homiey], grid, first_spot, stepped_on_9s)
    end
  end
  score
end

##################
# EVERY PART LOL #
##################

hilly_hills = 0

ground_level_locations.each do |ground_level_location|
  hilly_hills += get_lifted(ground_level_location, grid, ground_level_location, stepped_on_9s)
end

puts  "IN THE MOUNTAINS: #{hilly_hills}"

