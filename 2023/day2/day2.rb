
def can_game_fit?(red_max, green_max, blue_max, current_rocks)
  current_rocks[:red] <= red_max && current_rocks[:green] <= green_max && current_rocks[:blue] <= blue_max
end

lines = File.readlines('input.txt')
blank_object = {:red => 0, :green => 0, :blue => 0}
total = 0
lines.each do |line|
  current_max = blank_object.dup
  hands = line.split(';')
  hands.each do |hand|
    revised_hand = hand.split(': ')[1] if hand.include?(': ')
    revised_hand = hand if revised_hand.nil?
    revised_hand = revised_hand.split(',')
    revised_hand.each do |rock|
      rock = rock.split(' ')
      current_max[rock[1].to_sym] = rock[0].to_i if rock[0].to_i > current_max[rock[1].to_sym]
    end
  end
  # if can_game_fit?(12, 13, 14, current_max)
  #   total += line.split(': ')[0].split(' ')[1].to_i
  # end
  power = 1
  current_max.each do |key, value|
    power *= value
  end
  total += power
end
puts total
