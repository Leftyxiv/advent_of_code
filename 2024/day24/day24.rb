initial_wire_values, gate_connections = File.read('2024/day24/input.txt', chomp: true).split("\n\n")
initial_wire_values = initial_wire_values.split("\n")
value_store = Hash.new(0)

def and_gate(a, b)
  (a == 1 && b == 1) ? 1 : 0
end

def or_gate(a, b)
  (a == 1 || b == 1) ? 1 : 0
end

def xor_gate(a, b)
  a == b ? 0 : 1
end

initial_wire_values.each do |wire|
  location, value = wire.split(': ')
  value_store[location] = value.to_i
end
gate_store = Hash.new('')
gate_connections = gate_connections.split("\n")
gate_store = []
gate_connections.each do |gate|
  gates, output = gate.split(' -> ')
  gate_store << { expression: gates.strip, output: output.strip }
end

operations = {
  'AND' => method(:and_gate),
  'OR'  => method(:or_gate),
  'XOR' => method(:xor_gate)
}

pattern = /(\w+)\s+(AND|OR|XOR)\s+(\w+)/

unresolved_gates = gate_store.dup
progress = true

while unresolved_gates.any? && progress
  progress = false
  unresolved_gates.delete_if do |gate|
    match_data = pattern.match(gate[:expression])
    
    if match_data
      input1, gate_type, input2 = match_data.captures
      gate_method = operations[gate_type]
      
      # Check if both input wires are available
      if value_store.key?(input1) && value_store.key?(input2)
        # Perform the gate operation
        result = gate_method.call(value_store[input1], value_store[input2])
        
        # Check if the output wire is already set
        if value_store.key?(gate[:output])
          puts "Warning: Output wire '#{gate[:output]}' is already set. Skipping gate '#{gate[:expression]}'."
        else
          value_store[gate[:output]] = result
        end
        
        progress = true
        true
      else
        false
      end
    else
      puts "Invalid gate format: '#{gate[:expression]}'. Skipping..."
      true
    end
  end
end

if unresolved_gates.any?
  puts "Could not resolve the following gates due to missing inputs or circular dependencies:"
  unresolved_gates.each { |gate| puts gate[:expression] }
end

z_wires = value_store.select { |wire, _| wire.start_with?('z') }
sorted_z_wires = z_wires.sort_by { |wire, _| wire[1..-1].to_i }
sorted_z_wires.reverse!
binary_str = sorted_z_wires.map { |_, value| value }.join

decimal_output = binary_str.to_i(2)

puts "Binary (z wires): #{binary_str}"
puts "Decimal Output: #{decimal_output}"