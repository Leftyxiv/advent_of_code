# lines = """vJrwpWtwJgWrhcsFMMfFFhFp
# jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
# PmmdzqPrVvPwwTWBwg
# wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
# ttgJtRGJQctTZtZT
# CrZsJsPPZsGzwwsLwLmpwMDw""".split("\n")

##########
# Part 1 #
##########
lines = File.read('2022/day3/input.txt').split("\n")
def get_priority(char)
  char.ord - (char.ord < 97 ? 38 : 96)
end

def get_compartments(string)
  string.chars.each_slice(string.length / 2).to_a
end

part_one_total = 0

part_one_total = lines.sum do |line|
  compartment_one, compartment_two = get_compartments(line)
  common_chars = compartment_one & compartment_two
  common_chars.sum { |char| get_priority(char) }
end

puts "Part 1: #{part_one_total}"

##########
# Part 2 #
##########
part_two_total = 0

part_two_total = lines.each_slice(3).sum do |group|
  common_chars = group.map(&:chars).reduce(:&)

  get_priority(common_chars.first)
end

puts "Part 2: #{part_two_total}"