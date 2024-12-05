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
part_two_warchest = []
lines[1].each do |inputs|
  rules_unbroken = true
  updates = inputs.split(',')
  lines[0].each do |rule|
    first_num, second_num = rule.split('|')
    if updates.include?(first_num) && updates.include?(second_num) && !(updates.include?(first_num) && updates.include?(second_num) && updates.index(first_num) < updates.index(second_num))
      rules_unbroken = false
      part_two_warchest << updates
    end
  end
  if rules_unbroken
    part_one += updates[updates.size / 2].to_i
  end
end

puts "Part 1: #{part_one}"
##########
# Part 2 #
##########
part_two = 0
part_two_warchest.uniq!

def correctly_ordered?(updates, rules)
  rules.each do |rule|
    first, second = rule.split('|')
    if updates.include?(first) && updates.include?(second)
      return false unless updates.index(first) < updates.index(second)
    end
  end
  true
end

def topological_sort(elements, rules)
  graph = Hash.new { |hash, key| hash[key] = [] }
  in_degree = Hash.new(0)

  elements.each { |element| in_degree[element] = 0 }

  rules.each do |rule|
    first, second = rule.split('|')
    if elements.include?(first) && elements.include?(second)
      graph[first] << second
      in_degree[second] += 1
    end
  end

  queue = elements.select { |el| in_degree[el].zero? }
  sorted_order = []

  until queue.empty?
    node = queue.shift
    sorted_order << node

    graph[node].each do |neighbor|
      in_degree[neighbor] -= 1
      queue << neighbor if in_degree[neighbor].zero?
    end
  end

  sorted_order.size == elements.size ? sorted_order : []
end

part_two_warchest.each do |war_chest|
  ordered = topological_sort(war_chest, lines[0])
  unless ordered.empty?
    part_two += ordered[ordered.size / 2].to_i
  end
end


puts "Part 2: #{part_two}"
