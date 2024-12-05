# lines = """47|53
# 97|13
# 97|61
# 97|47
# 75|29
# 61|13
# 75|53
# 29|13
# 97|29
# 53|29
# 61|53
# 97|53
# 61|29
# 47|13
# 75|47
# 97|75
# 47|61
# 75|61
# 47|29
# 75|13
# 53|13

# 75,47,61,53,29
# 97,61,53,29,13
# 75,29,13
# 75,97,47,61,53
# 61,13,29
# 97,13,75,29,47""".split("\n\n").map { |line| line.split("\n") }
lines = File.read('2024/day5/input.txt').split("\n\n").map { |line| line.split("\n") }

##########
# Part 1 #
##########

page_store = {}

lines[0].each do |line|
  page_store[line.split('|').first] ||= []
  page_store[line.split('|').first] << line.split('|').last
end

part_one = 0
current_page = ''
lines[1].each do |inputs|
  rules_unbroken = true
  updates = inputs.split(',')
  lines[0].each do |rule|
    first_num, second_num = rule.split('|')
    if updates.include?(first_num) && updates.include?(second_num) && !(updates.include?(first_num) && updates.include?(second_num) && updates.index(first_num) < updates.index(second_num))
      rules_unbroken = false
    end
  end
  if rules_unbroken
    part_one += updates[updates.size / 2].to_i
  end
end

puts "Part 1: #{part_one}"