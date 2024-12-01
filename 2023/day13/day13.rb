lines = File.readlines('2023/day13/sample.txt').map(&:chomp)

lines = lines.map { |line| line.split('\n') }

grids = []

grid = []
lines.each do |line|
  if line == []
    grids << grid
    grid = []
  end
  grid << line
end

horizontal_mirrors = []
vertical_mirrors = []

def get_horizontal_mirrors(grid, store)


end

puts grids.inspect