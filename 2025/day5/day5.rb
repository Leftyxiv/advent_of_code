##########
# Part 1 #
##########

lines = File.readlines('2025/day5/input.txt').map(&:chomp)
dilineation = lines.index('')
fresh_ingredients_list = lines[0..dilineation - 1]
actual_ingredients_list = lines[dilineation + 1..]

part_one = 0

actual_ingredients_list.each do |ingredient|
  int_ingredient = ingredient.to_i
  fresh_ingredients_list.each do |fresh_ingredient|
    fresh_ingredient_range = fresh_ingredient.split('-').map(&:to_i)
    if int_ingredient >= fresh_ingredient_range[0] && int_ingredient <= fresh_ingredient_range[1]
      part_one += 1
      break
    end
  end
end

puts "Part 1: #{part_one}"

##########
# Part 2 #
##########

# loop do
#   any_merges = false
#   ranges = []
#   current_range = []

#   fresh_ingredients_list.each do |fresh_ingredient|
#     fresh_ingredient_range = fresh_ingredient.split('-').map(&:to_i)
#     if current_range.empty?
#       current_range = fresh_ingredient_range
#     elsif current_range[1] >= fresh_ingredient_range[0] && current_range[0] <= fresh_ingredient_range[1]
#       any_merges = true
#       current_range[0] = [current_range[0], fresh_ingredient_range[0]].min
#       current_range[1] = [current_range[1], fresh_ingredient_range[1]].max
#     else
#       ranges << current_range
#       current_range = fresh_ingredient_range
#     end
#   end

#   ranges << current_range unless current_range.empty?

#   break unless any_merges

#   fresh_ingredients_list = ranges.map { |r| "#{r[0]}-#{r[1]}" }
# end

# fresh_ingredients_list.each do |fresh_ingredient|
#   fresh_ingredient_range = fresh_ingredient.split('-').map(&:to_i)
#   part_two += fresh_ingredient_range[1] - fresh_ingredient_range[0] + 1
# end
# 
sorted_ranges = fresh_ingredients_list.map { |r| r.split('-').map(&:to_i) }
                                      .sort_by { |r| r[0] }

merged = []
current_range = sorted_ranges.first

sorted_ranges[1..].each do |range|
  if current_range[1] >= range[0]
    current_range[1] = [current_range[1], range[1]].max
  else
    merged << current_range
    current_range = range
  end
end
merged << current_range

part_two = merged.sum { |r| r[1] - r[0] + 1 }
puts "Part 2: #{part_two}"

