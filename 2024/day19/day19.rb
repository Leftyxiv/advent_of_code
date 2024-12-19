input = File.read('2024/day19/sample.txt', chomp: true)
available_towels_section, angry_elves_stripe_order_section = input.split("\n\n")
available_towels = available_towels_section.split(', ').map(&:strip)
angry_elves_stripe_order = angry_elves_stripe_order_section.split("\n").map(&:strip)

most_stripes = available_towels.map { |towel| towel.size }.max


##########
# Part 2 #
##########

def can_do_the_thing(design, towels)
  dp = Array.new(design.length + 1, 0)

  dp[0] = 1

  (1..design.length).each do |i|
    towels.each do |towel|
      towel_length = towel.size
      
      if i >= towel_length
        substring = design[(i - towel_length)...i]

        if substring == towel
          dp[i] += dp[i - towel_length]
        end
      end
    end
  end
  dp[design.length]
end

part_one_combos = 0
picky_elves_count = 0
angry_elves_stripe_order.map do |design|
  ok_design_count = can_do_the_thing(design, available_towels)
  part_one_combos += 1  if ok_design_count > 0
  picky_elves_count += ok_design_count if ok_design_count > 0
end
puts "Number of makeable stripe patterns: #{part_one_combos}"
puts "Total umber of possible designs: #{picky_elves_count}"

########## PART ONE SAVED FOR POSTERITY ##########

# def can_do_the_thing?(design, towels)
#   return true if design.empty?

#   dp = Array.new(design.length + 1, false)
#   dp[0] = true

#   (1..design.length).each do |i|
#     towels.each do |towel|
#       towel_length = towel.size
#       if i >= towel_length && design[i - towel_length, towel_length] == towel
#         dp[i] = dp[i] || dp[i - towel_length]
#       end
#       break if dp[i]
#     end
#   end

#   dp[design.length]
# end

##########
# Part 1 #
##########

# possible_count = 0
# angry_elves_stripe_order.each do |design|
#   if can_do_the_thing?(design, available_towels)
#     possible_count += 1
#   end
# end

# puts "Number of possible designs: #{possible_count}"