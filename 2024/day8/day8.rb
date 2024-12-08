require_relative '../../utils/griderator'

# lines = """............
# ........0...
# .....0......
# .......0....
# ....0.......
# ......A.....
# ............
# ............
# ........A...
# .........A..
# ............
# ............""".split("\n")
lines = File.read('2024/day8/input.txt').split("\n")

grid = Griderator5000.new(lines)

nodes = grid.find_all_not_locations('.')

node_store = {}
stupid_jammer_antenna = []

nodes.each do |node|
  node_store[grid[node[0], node[1]]] ||= []
  node_store[grid[node[0], node[1]]] << node
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
    # next if index == value.length - 1

    # diff = grid.get_difference(value[index], value[index + 1])
    # anti_node_one = [value[index + 1][0] + diff[0], value[index + 1][1] + diff[1]]
    # anti_node_two = [node[0] - diff[0], node[1] - diff[1]]
    # puts [node.inspect, value[index + 1].inspect, anti_node_one.inspect, anti_node_two.inspect].inspect
    # anti_node_locs << anti_node_one
    # anti_node_locs << anti_node_two
  end
end
puts "Part 1: #{stupid_jammer_antenna.uniq.size}"
