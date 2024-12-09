input = File.read('2024/day9/sample.txt')
# input = File.read('2024/day9/input.txt')

##########
# Part 1 #
##########

disk_mapped_string = []
disk_item_numba = 0
part_one = false

input.split('').each_with_index do |thingy, index|
  thingy.to_i.times do
    thing_to_shovel_in = index.even? ? disk_item_numba.to_s : '.'
    disk_mapped_string << thing_to_shovel_in
  end
  disk_item_numba += index.even? ? 1 : 0
end

if part_one
  while (first_dot_index = disk_mapped_string.index('.')) && (last_number_index = disk_mapped_string.rindex { |ch| ch.match?(/[0-9]/) }) && first_dot_index < last_number_index do
    last_number = disk_mapped_string[last_number_index]
    
    disk_mapped_string[first_dot_index] = last_number
    disk_mapped_string[last_number_index] = '.'
  end

  part_one = 0

  disk_mapped_string.each_with_index do |thingy, index|
    break if thingy == '.'

    part_one += thingy.to_i * index
  end

  puts "Part 1: #{part_one}"
end

##########
# Part 2 #
##########

if !part_one
  part_two = 0
  dot_store = {}
  numba_store = {}
  
  is_dot = false
  last_dot_index = 0

  disk_mapped_string.each_with_index do |thingy, index|
    if thingy == '.' && !is_dot
      last_dot_index = index
      dot_store[last_dot_index] = dot_store.fetch(last_dot_index, 0) + 1
      is_dot = true
    elsif thingy.match?(/\d+/)
      numba_store[thingy] = numba_store.fetch(thingy, 0) + 1
      is_dot = false
    else
      dot_store[last_dot_index] = dot_store.fetch(last_dot_index, 0) + 1
    end
  end

  numba_store.reverse_each do |numba_key, numba_count|
    required_space = numba_count

    dot_store.keys.sort.each do |dot_key|
      dot_count = dot_store[dot_key]

      if dot_count >= required_space
        current_index = dot_key
        
        numba_count.times do |i|
          disk_mapped_string[current_index] = numba_key
          current_index += 1

          right_index = disk_mapped_string.rindex(numba_key)
          disk_mapped_string[right_index] = '.'
        end

        remaining_space = dot_count - required_space
        if remaining_space > 0
          dot_store[current_index] = remaining_space
        end
        dot_store.delete(dot_key)

        break
      end
    end
  end

  disk_mapped_string.each_with_index do |thingy, index|
    next if thingy == '.'

    part_two += thingy.to_i * index
  end
  puts "Part 2: #{part_two}"
end