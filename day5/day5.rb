lines = File.readlines('sample.txt').map(&:chomp)

seeds = lines[0].split('seeds: ')[1].split(' ').map(&:to_i)
seeds = seeds.map { |seed| [seed] }
starting_seed_value = []
seed_steps = []
new_seeds = []

seeds.each_with_index do |seed, index|
 starting_seed_value << seed if index % 2 == 0
 seed_steps << seed if index % 2 == 1
end

starting_seed_value.each_with_index do |seed, index|
  count = 0
  while count < seed_steps[index][0]
    new_seeds << [seed[0] + count]
    count += 1
  end
end

new_seeds.each do |seed|
  lines.each_with_index do |line, index|
    if line.include? 'seed-to-soil map:'
      map_index = index + 1
      while (!lines[map_index].include? 'map:' || lines[map_index].length != 0)
        break if lines[map_index].length == 0
        
        current_line = lines[map_index].split(' ').map(&:to_i)
        
        unless seed[0] >= current_line[1] && seed[0] < current_line[1] + current_line[2]
          map_index += 1
          next
        end
        
        (current_line[1]...current_line[1] + current_line[2]).each_with_index do |i, digit|
          check_number_increment = 0
          while seed[0] >  i + check_number_increment
            check_number_increment += 1_000_000_000
          end
          while seed[0] <  i + check_number_increment
            check_number_increment -= 1_000_000
          end
          while seed[0] != i + check_number_increment
            check_number_increment += 1
          end
          seed << (i + check_number_increment) + (current_line[0] - current_line[1])
          break
        end
        map_index += 1
      end
    end
  end
  if seed.length == 1
    seed << seed[0]
  end

  lines.each_with_index do |line, index|
    if line.include? 'soil-to-fertilizer map:'
      map_index = index + 1
      while (!lines[map_index].include? 'map:' || lines[map_index].length != 0)
        break if lines[map_index].length == 0
        
        current_line = lines[map_index].split(' ').map(&:to_i)
        
        unless seed[1] >= current_line[1] && seed[1] < current_line[1] + current_line[2]
          map_index += 1
          next
        end
        
        (current_line[1]...current_line[1] + current_line[2]).each_with_index do |i, digit|
          check_number_increment = 0
          while seed[1] >  i + check_number_increment
            check_number_increment += 1_000_000_000
          end
          while seed[1] <  i + check_number_increment
            check_number_increment -= 1_000_000
          end
          while seed[1] != i + check_number_increment
            check_number_increment += 1
          end
          seed << (i + check_number_increment) + (current_line[0] - current_line[1])
          break
        end
        map_index += 1
      end
    end
  end
  if seed.length == 2
    seed << seed[1]
  end

  lines.each_with_index do |line, index|
    if line.include? 'fertilizer-to-water map:'
      map_index = index + 1
      while (!lines[map_index].include? 'map:' || lines[map_index].length != 0)
        break if lines[map_index].length == 0
        
        current_line = lines[map_index].split(' ').map(&:to_i)
        
        unless seed[2] >= current_line[1] && seed[2] < current_line[1] + current_line[2]
          map_index += 1
          next
        end
        
        (current_line[1]...current_line[1] + current_line[2]).each_with_index do |i, digit|
          check_number_increment = 0
          while seed[2] >  i + check_number_increment
            check_number_increment += 1_000_000_000
          end
          while seed[2] <  i + check_number_increment
            check_number_increment -= 1_000_000
          end
          while seed[2] != i + check_number_increment
            check_number_increment += 1
          end
          seed << (i + check_number_increment) + (current_line[0] - current_line[1])
          break
        end
        map_index += 1
      end
    end
  end
  if seed.length == 3
    seed << seed[2]
  end

  lines.each_with_index do |line, index|
    if line.include? 'water-to-light map:'
      map_index = index + 1
      while (!lines[map_index].include? 'map:' || lines[map_index].length != 0)
        break if lines[map_index].length == 0
        
        current_line = lines[map_index].split(' ').map(&:to_i)
        
        unless seed[3] >= current_line[1] && seed[3] < current_line[1] + current_line[2]
          map_index += 1
          next
        end
        
        (current_line[1]...current_line[1] + current_line[2]).each_with_index do |i, digit|
          check_number_increment = 0
          while seed[3] >  i + check_number_increment
            check_number_increment += 1_000_000_000
          end
          while seed[3] <  i + check_number_increment
            check_number_increment -= 1_000_000
          end
          while seed[3] != i + check_number_increment
            check_number_increment += 1
          end
          seed << (i + check_number_increment) + (current_line[0] - current_line[1])
          break
        end
        map_index += 1
      end
    end
  end
  if seed.length == 4
    seed << seed[3]
  end

  lines.each_with_index do |line, index|
    if line.include? 'light-to-temperature map:'
      map_index = index + 1
      while (!lines[map_index].include? 'map:' || lines[map_index].length != 0)
        break if lines[map_index].length == 0
        
        current_line = lines[map_index].split(' ').map(&:to_i)
        
        unless seed[4] >= current_line[1] && seed[4] < current_line[1] + current_line[2]
          map_index += 1
          next
        end
        
        (current_line[1]...current_line[1] + current_line[2]).each_with_index do |i, digit|
          check_number_increment = 0
          while seed[4] >  i + check_number_increment
            check_number_increment += 1_000_000_000
          end
          while seed[4] <  i + check_number_increment
            check_number_increment -= 1_000_000
          end
          while seed[4] != i + check_number_increment
            check_number_increment += 1
          end
          seed << (i + check_number_increment) + (current_line[0] - current_line[1])
          break
        end
        map_index += 1
      end
    end
  end
  if seed.length == 5
    seed << seed[4]
  end

  lines.each_with_index do |line, index|
    if line.include? 'temperature-to-humidity map:'
      map_index = index + 1
      while (!lines[map_index].include? 'map:' || lines[map_index].length != 0)
        break if lines[map_index].length == 0
        
        current_line = lines[map_index].split(' ').map(&:to_i)
        
        unless seed[5] >= current_line[1] && seed[5] < current_line[1] + current_line[2]
          map_index += 1
          next
        end
        
        (current_line[1]...current_line[1] + current_line[2]).each_with_index do |i, digit|
          check_number_increment = 0
          while seed[5] >  i + check_number_increment
            check_number_increment += 1_000_000_000
          end
          while seed[5] <  i + check_number_increment
            check_number_increment -= 1_000_000
          end
          while seed[5] != i + check_number_increment
            check_number_increment += 1
          end
          seed << (i + check_number_increment) + (current_line[0] - current_line[1])
          break
        end
        map_index += 1
      end
    end
  end
  if seed.length == 6
    seed << seed[5]
  end

  lines.each_with_index do |line, index|
    if line.include? 'humidity-to-location map:'
      map_index = index + 1
      while (lines[map_index] && (!lines[map_index].include?('map:') || lines[map_index].length != 0))
        break if lines[map_index].length == 0
        
        current_line = lines[map_index].split(' ').map(&:to_i)
        
        unless seed[6] >= current_line[1] && seed[6] < current_line[1] + current_line[2]
          map_index += 1
          next
        end
        
        (current_line[1]...current_line[1] + current_line[2]).each_with_index do |i, digit|
          check_number_increment = 0
          while seed[6] >  i + check_number_increment
            check_number_increment += 1_000_000_000
          end
          while seed[6] <  i + check_number_increment
            check_number_increment -= 1_000_000
          end
          while seed[6] != i + check_number_increment
            check_number_increment += 1
          end
          seed << (i + check_number_increment) + (current_line[0] - current_line[1])
          break
        end
        map_index += 1
        break if map_index >= lines.length
      end
    end
  end
  if seed.length == 7
    seed << seed[6]
  end
end

min = 9999999 * 9999999 * 9999999
new_seeds.each do |seed|
  if seed[7] < min
    min = seed[7]
  end
end

puts min


# lines.each_with_index do |line, index|
#   if line.include? 'soil-to-fertilizer map:'
#     map_index = index + 1
#     while (!lines[map_index].include? 'map:' || lines[map_index].length != 0)
#       break if lines[map_index].length == 0
      
#       current_line = lines[map_index].split(' ').map(&:to_i)
#       unless seeds[0][0] > current_line[1] && seeds[0][0] < current_line[1] + current_line[2]
#         map_index += 1
#         next
#       end

#       (current_line[1]...current_line[1] + current_line[2]).each_with_index do |i, digit|
#         seeds.each do |seed|
#           if seed[1] == i
#             seed << current_line[0] + digit
#           end
#         end
#       end
#       map_index += 1
#     end
#   end
# end
# if seeds.length == 2
#   seeds << seeds[1]
# end
# puts seeds.inspect

# lines.each_with_index do |line, index|
#   if line.include? 'fertilizer-to-water map:'
#     map_index = index + 1
#     while (!lines[map_index].include? 'map:' || lines[map_index].length != 0)
#       break if lines[map_index].length == 0
      
#       current_line = lines[map_index].split(' ').map(&:to_i)
#       unless seeds[0][0] > current_line[1] && seeds[0][0] < current_line[1] + current_line[2]
#         map_index += 1
#         next
#       end

#       (current_line[1]...current_line[1] + current_line[2]).each_with_index do |i, digit|
#         seeds.each do |seed|
#           if seed[2] == i
#             seed << current_line[0] + digit
#           end
#         end
#       end
#       map_index += 1
#     end
#   end
# end
# if seeds.length == 2
#   seeds << seeds[1]
# end
# puts seeds.inspect

#********************************************************************************************************

# lines.each_with_index do |line, index|
#   map = []
#     if line.include? 'seed-to-soil map:'
#     map_index = index + 1
#     while (!lines[map_index].include? 'map:' || lines[map_index].length != 0)
#       break if lines[map_index].length == 0
      
#       current_line = lines[map_index].split(' ').map(&:to_i)
#       (current_line[1]...current_line[1] + current_line[2]).each_with_index do |i, digit|
#         map[i] = [i, current_line[0] + digit]
#       end
#       map_index += 1
#     end
#   end
#   seeds.each do |seed|
#     map.each do |soil|
#       next if soil.nil?
      
#       if soil[0] == seed[0]
#         seed << soil[1]
#         break
#       end
#     end
#   end
# end
# seeds.each do |seed|
#   if seed.length == 1
#     seed << seed[0]
#   end
# end

# puts seeds.inspect

# lines.each_with_index do |line, index|
#   map = []
#   if line.include? 'soil-to-fertilizer map:'
#     map_index = index + 1
#     while (!lines[map_index].include? 'map:' || lines[map_index].length != 0)
#       break if lines[map_index].length == 0
      
#       current_line = lines[map_index].split(' ').map(&:to_i)
#       (current_line[1]...current_line[1] + current_line[2]).each_with_index do |i, digit|
#         map[i] = [i, current_line[0] + digit]
#       end
#       map_index += 1
#     end
#   end
#   next if map.empty?

#   seeds.each do |seed|
#     map.each do |soil|
#       next if soil.nil?
      
#       if soil[0] == seed[1]
#         seed << soil[1]
#         break
#       end
#     end
#   end
# end
# seeds.each do |seed|
#   if seed.length == 2
#     seed << seed[1]
#   end
# end

# lines.each_with_index do |line, index|
#   map = []
#   if line.include? 'fertilizer-to-water map:'
#     map_index = index + 1
#     while (!lines[map_index].include? 'map:' || lines[map_index].length != 0)
#       break if lines[map_index].length == 0
      
#       current_line = lines[map_index].split(' ').map(&:to_i)
#       (current_line[1]...current_line[1] + current_line[2]).each_with_index do |i, digit|
#         map[i] = [i, current_line[0] + digit]
#       end
#       map_index += 1
#     end
#   end
#   next if map.empty?

#   seeds.each do |seed|
#     map.each do |soil|
#       next if soil.nil?
      
#       if soil[0] == seed[2]
#         seed << soil[1]
#         break
#       end
#     end
#   end
# end
# seeds.each do |seed|
#   if seed.length == 3
#     seed << seed[2]
#   end
# end

# lines.each_with_index do |line, index|
#   map = []
#   if line.include? 'water-to-light map:'
#     map_index = index + 1
#     while (!lines[map_index].include? 'map:' || lines[map_index].length != 0)
#       break if lines[map_index].length == 0
      
#       current_line = lines[map_index].split(' ').map(&:to_i)
#       (current_line[1]...current_line[1] + current_line[2]).each_with_index do |i, digit|
#         map[i] = [i, current_line[0] + digit]
#       end
#       map_index += 1
#     end
#   end
#   next if map.empty?

#   seeds.each do |seed|
#     map.each do |soil|
#       next if soil.nil?
      
#       if soil[0] == seed[3]
#         seed << soil[1]
#         break
#       end
#     end
#   end
# end
# seeds.each do |seed|
#   if seed.length == 4
#     seed << seed[3]
#   end
# end

# lines.each_with_index do |line, index|
#   map = []
#   if line.include? 'light-to-temperature map:'
#     map_index = index + 1
#     while (!lines[map_index].include? 'map:' || lines[map_index].length != 0)
#       break if lines[map_index].length == 0
      
#       current_line = lines[map_index].split(' ').map(&:to_i)
#       (current_line[1]...current_line[1] + current_line[2]).each_with_index do |i, digit|
#         map[i] = [i, current_line[0] + digit]
#       end
#       map_index += 1
#     end
#   end
#   next if map.empty?

#   seeds.each do |seed|
#     map.each do |soil|
#       next if soil.nil?
      
#       if soil[0] == seed[4]
#         seed << soil[1]
#         break
#       end
#     end
#   end
# end
# seeds.each do |seed|
#   if seed.length == 5
#     seed << seed[4]
#   end
# end

# lines.each_with_index do |line, index|
#   map = []
#   if line.include? 'temperature-to-humidity map:'
#     map_index = index + 1
#     while (!lines[map_index].include? 'map:' || lines[map_index].length != 0)
#       break if lines[map_index].length == 0
      
#       current_line = lines[map_index].split(' ').map(&:to_i)
#       (current_line[1]...current_line[1] + current_line[2]).each_with_index do |i, digit|
#         map[i] = [i, current_line[0] + digit]
#       end
#       map_index += 1
#     end
#   end
#   next if map.empty?

#   seeds.each do |seed|
#     map.each do |soil|
#       next if soil.nil?
      
#       if soil[0] == seed[5]
#         seed << soil[1]
#         break
#       end
#     end
#   end
# end
# seeds.each do |seed|
#   if seed.length == 6
#     seed << seed[5]
#   end
# end

# lines.each_with_index do |line, index|
#   map = []
#   if line.include? 'humidity-to-location map:'
#     map_index = index + 1
#     while (lines[map_index] && (!lines[map_index].include?('map:') || lines[map_index].length != 0))
#       break if lines[map_index].length == 0
      
#       current_line = lines[map_index].split(' ').map(&:to_i)
#       (current_line[1]...current_line[1] + current_line[2]).each_with_index do |i, digit|
#         map[i] = [i, current_line[0] + digit]
#       end
#       map_index += 1
#     end
#   end
#   next if map.empty?

#   seeds.each do |seed|
#     map.each do |soil|
#       next if soil.nil?
      
#       if soil[0] == seed[6]
#         seed << soil[1]
#         break
#       end
#     end
#   end
# end
# seeds.each do |seed|
#   if seed.length == 7
#     seed << seed[6]
#   end
# end

# min = 99999 * 9999999 * 99999
# seeds.each do |seed|
#   if seed.length == 8 && seed[7] < min
#     min = seed[7]
#   end
# end
# puts min

# **********************************************************************

# seed_to_soil_map = []
# seeds = []
# lines.each_with_index do |line, index|
#   if line.include? 'seeds: '
#     seeds = line.split('seeds: ')[1].split(' ').map(&:to_i)
#   end
#   if line.include? 'seed-to-soil map:'
#     map_index = index + 1
#     while (!lines[map_index].include? 'map:' || lines[map_index].length != 0)
#       break if lines[map_index].length == 0
      
#       current_line = lines[map_index].split(' ').map(&:to_i)
#       (current_line[1]...current_line[1] + current_line[2]).each_with_index do |i, digit|
#         seed_to_soil_map[i] = [i, current_line[0] + digit]
#       end
#       map_index += 1
#     end
#     seed_to_soil_map.each_with_index do |soil, index|
#       if soil.nil?
#         seed_to_soil_map[index] = [index, index]
#       end
#     end
#   end
#   if line.include? 'soil-to-fertilizer map:'
#     map_index = index + 1
#     while (!lines[map_index].include? 'map:' || lines[map_index].length != 0)
#       break if lines[map_index].length == 0
      
#       current_line = lines[map_index].split(' ').map(&:to_i)
#       (current_line[1]...current_line[1] + current_line[2]).each_with_index do |i, digit|
#         seed_to_soil_map[current_line[1] + digit] << current_line[0] + digit
#       end
#       map_index += 1
#     end
#     seed_to_soil_map.each_with_index do |soil, index|
#       if seed_to_soil_map[index].length == 2
#         seed_to_soil_map[index] << seed_to_soil_map[index][1]
#       end
#     end
#   end
#   if line.include? 'fertilizer-to-water map:'
#     map_index = index + 1
#     while (!lines[map_index].include? 'map:' || lines[map_index].length != 0)
#       break if lines[map_index].length == 0
      
#       current_line = lines[map_index].split(' ').map(&:to_i)
#       (current_line[1]...current_line[1] + current_line[2]).each_with_index do |i, digit|
#         seed_to_soil_map.each do |index|
#           if index[2] == current_line[1] + digit
#             index << current_line[0] + digit
#           end
#         end
#       end
#       map_index += 1
#     end
#     seed_to_soil_map.each_with_index do |soil, index|
#       if seed_to_soil_map[index].length == 3
#         seed_to_soil_map[index] << seed_to_soil_map[index][2]
#       end
#     end
#   end
#   if line.include? 'water-to-light map:'
#     map_index = index + 1
#     while (!lines[map_index].include? 'map:' || lines[map_index].length != 0)
#       break if lines[map_index].length == 0
      
#       current_line = lines[map_index].split(' ').map(&:to_i)
#       (current_line[1]...current_line[1] + current_line[2]).each_with_index do |i, digit|
#         seed_to_soil_map.each do |index|
#           if index[3] == current_line[1] + digit
#             index << current_line[0] + digit
#           end
#         end
#       end
#       map_index += 1
#     end
#     seed_to_soil_map.each_with_index do |soil, index|
#       if seed_to_soil_map[index].length == 4
#         seed_to_soil_map[index] << seed_to_soil_map[index][3]
#       end
#     end
#   end
#   if line.include? 'light-to-temperature map:'
#     map_index = index + 1
#     while (!lines[map_index].include? 'map:' || lines[map_index].length != 0)
#       break if lines[map_index].length == 0
      
#       current_line = lines[map_index].split(' ').map(&:to_i)
#       (current_line[1]...current_line[1] + current_line[2]).each_with_index do |i, digit|
#         seed_to_soil_map.each do |index|
#           if index[4] == current_line[1] + digit
#             index << current_line[0] + digit
#           end
#         end
#       end
#       map_index += 1
#     end
#     seed_to_soil_map.each_with_index do |soil, index|
#       if seed_to_soil_map[index].length == 5
#         seed_to_soil_map[index] << seed_to_soil_map[index][4]
#       end
#     end
#   end
#   if line.include? 'temperature-to-humidity map:'
#     map_index = index + 1
#     while (!lines[map_index].include? 'map:' || lines[map_index].length != 0)
#       break if lines[map_index].length == 0
      
#       current_line = lines[map_index].split(' ').map(&:to_i)
#       (current_line[1]...current_line[1] + current_line[2]).each_with_index do |i, digit|
#         seed_to_soil_map.each do |index|
#           if index[5] == current_line[1] + digit
#             index << current_line[0] + digit
#           end
#         end
#       end
#       map_index += 1
#     end
#     seed_to_soil_map.each_with_index do |soil, index|
#       if seed_to_soil_map[index].length == 6
#         seed_to_soil_map[index] << seed_to_soil_map[index][5]
#       end
#     end
#   end
#   if line.include? 'humidity-to-location map:'
#     map_index = index + 1
#     while (!lines[map_index].include? 'map:' || lines[map_index].length != 0)
#       break if lines[map_index].length == 0
      
#       current_line = lines[map_index].split(' ').map(&:to_i)
#       (current_line[1]...current_line[1] + current_line[2]).each_with_index do |i, digit|
#         seed_to_soil_map.each do |index|
#           if index[6] == current_line[1] + digit
#             index << current_line[0] + digit
#           end
#         end
#       end
#       map_index += 1
#       if map_index == lines.length
#         break
#       end
#     end
#     seed_to_soil_map.each_with_index do |soil, index|
#       if seed_to_soil_map[index].length == 7
#         seed_to_soil_map[index] << seed_to_soil_map[index][6]
#       end
#     end
#   end
# end
# puts seeds.inspect
# min = 1000000
# seeds.each do |seed|
#   if seed_to_soil_map[seed][7] < min
#     min = seed_to_soil_map[seed][7]
#   end
# end
# puts min
