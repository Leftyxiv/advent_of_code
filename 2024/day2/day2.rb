# lines = """7 6 4 2 1
# 1 2 7 8 9
# 9 7 6 2 1
# 1 3 2 4 5
# 8 6 4 4 1
# 1 3 6 7 9""".split("\n")

lines = File.read('2024/day2/input.txt').split("\n")

##########
# Part 1 #
##########

def is_report_safe?(report)
  ascending = report.each_cons(2).all? { |a, b| b > a && (1..3).include?(b - a) }

  descending = report.each_cons(2).all? { |a, b| a > b && (1..3).include?(a - b) }

  ascending || descending
end

part_one_safe_count = lines.count do |line|
  report = line.split.map(&:to_i)
  is_report_safe?(report)
end

puts "Part 1: #{part_one_safe_count}"

##########
# Part 2 #
##########

def can_be_made_safe_by_one_removal?(report)
  report.each_index.any? do |i|
    temp_report = report.dup
    temp_report.delete_at(i)
    is_report_safe?(temp_report)
  end
end

part_two_safe_count = lines.count do |line|
  report = line.split.map(&:to_i)
  is_report_safe?(report) || can_be_made_safe_by_one_removal?(report)
end

puts "Part 2: #{part_two_safe_count}"