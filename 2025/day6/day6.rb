lines = File.readlines('2025/day6/input.txt').map(&:chomp)


##########
# Part 1 #
##########

maf_to_do = []
part_one = 0

lines.each_with_index do |line, index|
  nummbaz = line.split(' ')
  nummbaz.each_with_index do |numba, index|
    maf_to_do[index] ||= []
    maf_to_do[index] << numba
  end
end

# more_maf = File.readlines('2025/day6/sample.txt').map(&:chomp)

maf_to_do.each do |maf|
  operation = maf.pop
  maf.map!(&:to_i)
  part_one += operation == '+' ? maf.sum : maf.inject(:*)
end

puts "Part 1: #{part_one}"

##########
# Part 2 #
##########

# numbaz = []
# part_two = 0
# more_maf.each_with_index do |maf, prob_idx|
#   operation = maf.pop
#   numba_to_add = ''
#   i = 1
#   max_len = maf.max_by(&:length).length
#   maf.each do |numba|
#     if prob_idx.even?
#       numba.prepend(' ') while numba.length < max_len
#     else
#       numba << ' ' while numba.length < max_len
#     end
#   end

#   while i < maf.size + 1 do
#     maf.each do |numba|
#       numba_to_add += numba[-i] if numba[-i]
#     end
#     numbaz << numba_to_add.to_i
#     numba_to_add = ''
#     i += 1
#   end
#   part_two += operation == '+' ? numbaz.sum : numbaz.inject(:*)
#   numbaz = []
# end
# 
operator_line = lines[-1]

op_indices = []
operator_line.chars.each_with_index do |char, idx|
  op_indices << { idx: idx, op: char } if char =~ /[+*]/
end

problems = []
op_indices.each_with_index do |op_info, i|
  start_col = op_info[:idx]
  end_col = if i < op_indices.length - 1
    op_indices[i + 1][:idx] - 1
  else
    operator_line.length - 1
  end
  problems << { start: start_col, end: end_col, op: op_info[:op] }
end

part_two = 0

problems.reverse.each do |prob|
  columns = lines[0..-2].map { |line| line[prob[:start]..prob[:end]] }
  width = columns.first.length

  numbaz = []
  (width - 1).downto(0) do |col|
    numba = ''
    columns.each do |row|
      numba += row[col] if col < row.length && row[col] =~ /\d/
    end
    numbaz << numba.to_i unless numba.empty?
  end

  part_two += prob[:op] == '+' ? numbaz.sum : numbaz.inject(:*)
end

puts "Part 2: #{part_two}"

