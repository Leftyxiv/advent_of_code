require_relative '../../utils/griderator'

# lines = File.read('2024/day8/sample.txt').split("\n")
# lines = File.read('2024/day8/sample2.txt').split("\n")
lines = File.read('2024/day8/input.txt').split("\n")

grid = Griderator5000.new(lines)

nodes = grid.find_all_not_locations('.')

node_store = {}
node_list = []
stupid_jammer_antenna = []

nodes.each do |node|
  node_store[grid[node[0], node[1]]] ||= []
  node_store[grid[node[0], node[1]]] << node
  node_list << node
end
##########
# Part 1 #
##########


node_store.each do |key, value|
  value.each_with_index do |node, index|
    loop_count = 0
    loop do
      break if loop_count == value.length - 1 - index

      diff = grid.get_difference(value[index], value[index + 1 + loop_count])
      anti_node_one = [value[index + 1 + loop_count][0] + diff[0], value[index + 1 + loop_count][1] + diff[1]]
      anti_node_two = [node[0] - diff[0], node[1] - diff[1]]
      stupid_jammer_antenna << anti_node_one if grid.in_bounds?(anti_node_one[0], anti_node_one[1])
      stupid_jammer_antenna << anti_node_two if grid.in_bounds?(anti_node_two[0], anti_node_two[1])
      loop_count += 1
    end
  end
end

puts "Part 1: #{stupid_jammer_antenna.uniq.size}"

##########
# Part 2 #
##########

stupid_jammer_antenna_on_steroids = []

node_store.each do |key, value|
  value.each_with_index do |node, index|
    loop_count = 0
    loop do
      break if loop_count == value.length - 1 - index

      diff = grid.get_difference(value[index], value[index + 1 + loop_count])
      anti_node_one = [value[index + 1 + loop_count][0] + diff[0], value[index + 1 + loop_count][1] + diff[1]]
      anti_node_two = [node[0] - diff[0], node[1] - diff[1]]
      anti_node_one_multiplier = 2
      anti_node_two_multiplier = 2
      while grid.in_bounds?(anti_node_one[0], anti_node_one[1]) do
        stupid_jammer_antenna_on_steroids << anti_node_one
        anti_node_one = [value[index + 1 + loop_count][0] + diff[0] * anti_node_one_multiplier, value[index + 1 + loop_count][1] + diff[1] * anti_node_one_multiplier]
        anti_node_one_multiplier += 1
      end
      while grid.in_bounds?(anti_node_two[0], anti_node_two[1]) do
        stupid_jammer_antenna_on_steroids << anti_node_two
        anti_node_two = [node[0] - diff[0] * anti_node_two_multiplier, node[1] - diff[1] * anti_node_two_multiplier]
        anti_node_two_multiplier += 1
      end
      loop_count += 1
    end
  end
end

puts  "Part 2: #{stupid_jammer_antenna_on_steroids.concat(node_list).uniq.size}"