lines = File.readlines('input.txt').map(&:chomp)

# SYMBOLS = ['@', '#', '$', '%', '^', '&', '*', '(', ')', '-', '+', '=', '_', '!', '~', '`', '[', ']', '{', '}', '|', '\\', ':', ';', '"', "'", '<', '>', ',', '?', '/']
SYMBOLS = ['*']
total = 0
lines.each_with_index do |line, outer_index|
  line.each_char.with_index do |char, index|
    adjacent_parts = []
    if SYMBOLS.include?(char)
      # check the index to the left
      if line[index - 1] =~ /\d/  
        starting_index = index - 1
        while line[starting_index] =~ /\d/  
          starting_index -= 1
        end
        # total += line[(starting_index + 1)..(index - 1)].to_i
        adjacent_parts << line[(starting_index + 1)..(index - 1)]
        line[(starting_index + 1)..(index - 1)] = 'X' * (index - starting_index - 1)
      end
      # check the index to the right
      if line[index + 1] =~ /\d/  
        starting_index = index + 1
        while line[starting_index] =~ /\d/  
          starting_index += 1
        end
        # total += line[(index + 1)..(starting_index - 1)].to_i
        adjacent_parts << line[(index + 1)..(starting_index - 1)]
        line[(index + 1)..(starting_index - 1)] = 'X' * (starting_index - index - 1)
      end
      # check the index above, if it exists
      if outer_index > 0
        [-1, 0 , 1].each do |offset|
          if lines[outer_index - 1][index + offset] =~ /\d/
            starting_index = index + offset
            while lines[outer_index - 1][starting_index] =~ /\d/
              starting_index -= 1
            end
            ending_index = index + offset
            while lines[outer_index - 1][ending_index] =~ /\d/
              ending_index += 1
            end
            # total += lines[outer_index - 1][(starting_index + 1)..(ending_index -1)].to_i
            adjacent_parts << lines[outer_index - 1][(starting_index + 1)..(ending_index -1)]
            lines[outer_index - 1][(starting_index + 1)..(ending_index -1)] = 'X' * (ending_index - starting_index - 1)
          end
        end
      end
      # check the index below, if it exists
      if outer_index < lines.length - 1
        [-1, 0 , 1].each do |offset|
          if lines[outer_index + 1][index + offset] =~ /\d/
            starting_index = index + offset
            while lines[outer_index + 1][starting_index] =~ /\d/
              starting_index -= 1
            end
            ending_index = index + offset
            while lines[outer_index + 1][ending_index] =~ /\d/
              ending_index += 1
            end
            # total += lines[outer_index + 1][(starting_index + 1)..(ending_index -1)].to_i
            adjacent_parts << lines[outer_index + 1][(starting_index + 1)..(ending_index -1)]
            lines[outer_index + 1][(starting_index + 1)..(ending_index -1)] = 'X' * (ending_index - starting_index - 1)
          end
        end
      end
    end
    if adjacent_parts.length == 2
      total += adjacent_parts[0].to_i * adjacent_parts[1].to_i
    end
  end
end
# lines.each do |line|
#   puts line, line.length
# end
puts total