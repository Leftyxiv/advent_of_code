require_relative '../../utils/griderator'
lines = File.readlines('2025/day4/input.txt').map(&:chomp)

grid = Griderator5000.new(lines)

##########
# Part 1 #
##########

part_one = 0

grid.each_cell do |row, col, cell|
  if cell == '@'
    homies = grid.get_homies(row, col, diagonals: true)
    no_paper_neighbors = homies.reduce(0) do |sum, homie|
      sum + (grid[homie[0], homie[1]] == '@' ? 1 : 0)
    end
    if no_paper_neighbors < 4
      part_one += 1
    end
  end
end

puts "Part 1: #{part_one}"

##########
# Part 2 #
##########
part_two = 0

def do_the_thing(grid, papers_to_remove, part_two)
  grid.each_cell do |row, col, cell|
    if cell == '@'
      homies = grid.get_homies(row, col, diagonals: true)
      no_paper_neighbors = homies.reduce(0) do |sum, homie|
        sum + (grid[homie[0], homie[1]] == '@' ? 1 : 0)
      end
      if no_paper_neighbors < 4
        part_two += 1
        papers_to_remove << [row, col]
      end
    end
  end
  [papers_to_remove, part_two]
end

papers_to_remove, part_two = do_the_thing(grid, [], part_two)
while papers_to_remove.any?
  papers_to_remove.each do |paper|
    grid[paper[0], paper[1]] = '.'
  end
  papers_to_remove, part_two = do_the_thing(grid, [], part_two)
end

puts "Part 2: #{part_two}"