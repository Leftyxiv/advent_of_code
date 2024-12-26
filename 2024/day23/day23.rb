lines = File.readlines('2024/day23/input.txt', chomp: true)
require 'set'
##########
# part 1 #
##########

lan_party = Hash.new { |h, k| h[k] = [] }

lines.each do |line|
  c1, c2 = line.split('-')
  lan_party[c1] << c2
  lan_party[c2] << c1
end

interconnected_computers = []
part_one = 0

lan_party.each do |computer, neighbors|
  neighbors.each do |neighbor|
    next unless lan_party[neighbor].include?(computer)

    lan_party[neighbor].each do |neighbor_neighbor|
      interconnected_computers << [computer, neighbor, neighbor_neighbor].sort if lan_party[neighbor_neighbor].include?(computer)
    end
  end
end

connected_computers = interconnected_computers

interconnected_computers.uniq!


interconnected_computers.each do |line|
  part_one += 1 if line.any? { |computer| computer.start_with?('t') }
end

puts "Part 1: #{part_one}"

##########
# part 2 #
##########

##### GPT 1o USED ON PART 2 #####
# idk wtf a bron-kerbosch algorithm is, but I'm going to try to implement it

=begin
R: Current clique being built.
P: Potential candidates to expand the clique.
X: Candidates that have already been processed.
adj: The adjacency list representing the graph.
cliques: Array to store all maximal cliques found.
=end


# Bron-Kerbosch algorithm to find all maximal cliques
def bron_kerbosch_pivot(r, p, x, adj, cliques)
  if p.empty? && x.empty?
    cliques << r.dup
    return
  end

  # Choose a pivot (heuristic: choose the first vertex in P union X)
  u = (p | x).first
  # Explore vertices not adjacent to the pivot
  (p - adj[u]).each do |v|
    bron_kerbosch_pivot(
      r + [v],
      p & adj[v].to_set,
      x & adj[v].to_set,
      adj,
      cliques
    )
    p.delete(v)
    x << v
  end
end

# Initialize variables for the Bron-Kerbosch algorithm
r = []
p = lan_party.keys.to_set
x = Set.new
cliques = []

# Call the Bron-Kerbosch algorithm
bron_kerbosch_pivot(r, p, x, lan_party, cliques)

# Find the maximum clique
max_clique = cliques.max_by(&:size)

# Sort the computer names alphabetically and join with commas for the password
password = max_clique.sort.join(',')

puts "Part 2: #{password}"