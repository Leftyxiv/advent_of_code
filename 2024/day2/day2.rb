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

def is_report_safe?(report, allow_one_failure = false)
  failures = report.each_cons(2).all? { |a, b| b > a && b - a <= 3 && b - a >= 1 }
end

part_one = 0

lines.each do |line|
  report = line.split.map(&:to_i)
  if report[0] > report[1]
    report.reverse!
  end
  part_one += 1 if is_report_safe?(report)
end

puts "Part 1: #{part_one}"

def is_report_safe_with_dampener?(report)