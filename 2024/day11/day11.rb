line = File.read('2024/day11/input.txt')

stones = line.split(' ').map(&:to_i)
stone_string = line.split(' ')

########## I DONT UNDERSTAND WHY THIS METHOD THING ISNT WORKING
def blink(stones)
  new_stones = []
  stones.each do |stone|
    if stone == '0'
      new_stones << '1'
    elsif stone.size % 2 == 0
      first_half = stone[0..(stone.size / 2) - 1]
      second_half = stone[(stone.size / 2)..-1]

      first_half = first_half.start_with?('0') && first_half.size > 1 ? first_half[1..-1] : first_half
      second_half = second_half.start_with?('0') && second_half.size > 1 ? second_half[1..-1] : second_half

      new_stones << (first_half =~ /^0+$/ ? '0' : first_half)
      new_stones << (second_half =~ /^0+$/ ? '0' : second_half)
    else
      new_stones << (stone.to_i * 2024).to_s
    end
  end
  new_stones
end

##########
# Part 1 #
##########

# 25.times do
#   stone_string = blink(stone_string)
# end
# puts "Part 1: #{stone_string.size}"

def wtf_my_tally_stopped_working(stones)
  tally = Hash.new { 0 }
  stones.each do |stone|
    tally[stone] += 1
  end
  tally
end

muh_rocks = wtf_my_tally_stopped_working(stones)

75.times do
  muh_next_rocks = Hash.new { 0 }

  muh_rocks.each do |stone, count|
    if stone == 0
      muh_next_rocks[1] += count
      next
    end

    rock_numba = stone.to_s
    if rock_numba.size.even?
      muh_next_rocks[rock_numba[0, rock_numba.size / 2].to_i] += count
      muh_next_rocks[rock_numba[rock_numba.size / 2..].to_i] += count
      next
    end
    muh_next_rocks[rock_numba.to_i * 2024] += count
  end
  muh_rocks = muh_next_rocks
end

puts "Part 1: #{muh_rocks.values.sum}"
