require_relative '../../utils/griderator'

lines = File.readlines('2025/day4/input.txt').map(&:chomp)
grid = Griderator5000.new(lines)

MIN_NEIGHBORS_TO_STAY = 4

def count_paper_neighbors(grid, row, col)
  grid.get_homies(row, col, diagonals: true).count do |r, c|
    grid[r, c] == '@'
  end
end

def find_vulnerable_papers(grid)
  vulnerable = []
  grid.each_cell do |row, col, cell|
    next unless cell == '@'
    vulnerable << [row, col] if count_paper_neighbors(grid, row, col) < MIN_NEIGHBORS_TO_STAY
  end
  vulnerable
end

# Part 1: Count papers with fewer than 4 neighbors
part_one = find_vulnerable_papers(grid).size
puts "Part 1: #{part_one}"

# Part 2: Keep removing vulnerable papers until none remain
part_two = part_one

loop do
  vulnerable = find_vulnerable_papers(grid)
  break if vulnerable.empty?

  vulnerable.each { |row, col| grid[row, col] = '.' }
  part_two += find_vulnerable_papers(grid).size
end

puts "Part 2: #{part_two}"
