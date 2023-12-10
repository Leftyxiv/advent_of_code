lines = File.readlines('input.txt').map(&:chomp)

starting_rows = []
index = 0

lines.each do |line|
  numbers = line.split(' ')
  starting_rows[index] ||= []
  numbers.each do |number|
    starting_rows[index] << number.to_i
    starting_rows[index] << []
  end
  index += 1
end

steps = 0

starting_rows.map! do |row|
  [row]
end


starting_rows.each_with_index do |row, index|
  starting_index = 1
  while !starting_rows[index][starting_index - 1].map { |x| x == [] || x == 0}.all?
    starting_rows[index][starting_index] ||= []

    starting_rows[index][starting_index - 1].each_with_index do |number, i|
      next if number == []
      break if i == starting_rows[index][starting_index - 1].length - 2
      
      starting_rows[index][starting_index] << starting_rows[index][starting_index - 1][i + 2] - starting_rows[index][starting_index - 1][i]
      starting_rows[index][starting_index] << []
    end
    starting_index += 1
  end
end

next_histories = 0

starting_rows.each_with_index do |row, index|
  row.reverse!
  row.each_with_index do |number, i|
    if i == 0
      row[i].unshift(0)
    elsif i < row.length
      row[i].unshift(number[0] - row[i - 1][0])
      next
    end
  end
end

starting_rows.each do |row|
  next_histories += row[-1][0]
end

puts next_histories

# Part 1 loop
# starting_rows.each_with_index do |row, index|
#   row.reverse!
#   row.each_with_index do |number, i|
#     puts number.inspect
#     if i == 0
#       row[i] << 0
#     elsif i < row.length
#       row[i] << row[i][-2] + row[i - 1][-1]
#       next
#     end
#   end
# end
