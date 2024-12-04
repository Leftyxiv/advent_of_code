# lines = """MMMSXXMASM
# MSAMXMSMSA
# AMXSXMAAMM
# MSAMASMSMX
# XMASAMXAMM
# XXAMMXXAMA
# SMSMSASXSS
# SAXAMASAAA
# MAMMMXMMMM
# MXMXAXMASX""".split("\n")
lines = File.read('2024/day4/input.txt').split("\n")

def check_forward_line_for_xmas(line)
  line.each_cons(4).count { |quad| quad == %w[X M A S] }
end

def check_backward_line_for_xmas(line)
  line.reverse.each_cons(4).count { |quad| quad == %w[X M A S] }
end

def check_column_up_down_for_xmas(lines, col)
  lines.map { |line| line[col] }.each_cons(4).count { |quad| quad == %w[X M A S] }
end

def check_column_down_up_for_xmas(lines, col)
  lines.map { |line| line[col] }.reverse.each_cons(4).count { |quad| quad == %w[X M A S] }
end

def check_diagonal_forward_upward_for_xmas(lines, row, col)
  return 0 if row + 3 >= lines.size || col + 3 >= lines[0].size
  quad = (0..3).map { |i| lines[row + i][col + i] }
  quad == %w[X M A S] ? 1 : 0
end

def check_diagonal_forward_downward_for_xmas(lines, row, col)
  return 0 if row - 3 < 0 || col + 3 >= lines[0].size
  quad = (0..3).map { |i| lines[row - i][col + i] }
  quad == %w[X M A S] ? 1 : 0
end

def check_diagonal_backward_upward_for_xmas(lines, row, col)
  return 0 if row + 3 >= lines.size || col - 3 < 0
  quad = (0..3).map { |i| lines[row + i][col - i] }
  quad == %w[X M A S] ? 1 : 0
end

def check_diagonal_backward_downward_for_xmas(lines, row, col)
  return 0 if row - 3 < 0 || col - 3 < 0
  quad = (0..3).map { |i| lines[row - i][col - i] }
  quad == %w[X M A S] ? 1 : 0
end

##########
# Part 1 #
##########

part_one = 0

lines.each do |line|
  part_one += check_forward_line_for_xmas(line.chars)
  part_one += check_backward_line_for_xmas(line.chars)
end

lines.first.size.times do |col|
  part_one += check_column_up_down_for_xmas(lines, col)
  part_one += check_column_down_up_for_xmas(lines, col)
end

lines.each_with_index do |_line, row|
  lines.first.size.times do |col|
    part_one += check_diagonal_forward_upward_for_xmas(lines, row, col)
    part_one += check_diagonal_forward_downward_for_xmas(lines, row, col)
    part_one += check_diagonal_backward_upward_for_xmas(lines, row, col)
    part_one += check_diagonal_backward_downward_for_xmas(lines, row, col)
  end
end

puts "Part 1: #{part_one}"

##########
# Part 2 #
##########

part_two = 0

def find_x_shaped_mas(lines, row, col)
  return 0 if row + 1 >= lines.size || col + 1 >= lines[0].size
  return 0 if row - 1 < 0 || col - 1 < 0

  xmases = 0
  
  diagonal_left = [lines[row - 1][col - 1], lines[row][col], lines[row + 1][col + 1]]
  diagonal_right = [lines[row - 1][col + 1], lines[row][col], lines[row + 1][col - 1]]
  xmases += 1 if diagonal_left == %w[M A S] || diagonal_left == %w[S A M]
  xmases += 1 if diagonal_right == %w[M A S] || diagonal_right == %w[S A M]
  xmases == 2 ? 1 : 0
end

lines.each_with_index do |_line, row|
  lines.first.size.times do |col|
    part_two += find_x_shaped_mas(lines, row, col)
  end
end
puts "Part 2: #{part_two}"