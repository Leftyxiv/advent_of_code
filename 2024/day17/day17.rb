lines = File.read('2024/day17/sample2.txt').split("\n")
require 'set'
register_registry = {}
program = []
lines.each do |line|
  register_pattern = /Register (\w+): (\d+)/
  match = register_pattern.match(line)
  if match
    register_registry[match[1].to_sym] = match[2].to_i
  end
  program_match = line.match(/Program: (.+)/)
  program = program_match ? program_match[1].split(',').map(&:to_i) : []
end

def simulate_janky_computer(program, register_registry, max_steps = 1000)
  ip = 0
  output = []
  steps = 0

  while ip < program.size && steps < max_steps
    instruction = program[ip]
    operand = program[ip + 1]

    case instruction
    when 0
      register_registry[:A] = register_registry[:A] / (2 ** get_combo_meal(operand, register_registry))
    when 1
      register_registry[:B] = register_registry[:B] ^ operand
    when 2
      register_registry[:B] = get_combo_meal(operand, register_registry) % 8
    when 3
      if register_registry[:A] != 0
        ip = operand
        next
      end
    when 4
      register_registry[:B] = register_registry[:B] ^ register_registry[:C]
    when 5
      output << (get_combo_meal(operand, register_registry) % 8)
    when 6
      register_registry[:B] = register_registry[:A] / (2 ** get_combo_meal(operand, register_registry))
    when 7
      register_registry[:C] = register_registry[:A] / (2 ** get_combo_meal(operand, register_registry))
    end

    ip += 2
    steps += 1
    # break if output.length >= program.size
  end

  output
end


def get_combo_meal(operand, register_registry)
  case operand
  when 0..3 then operand
  when 4 then register_registry[:A]
  when 5 then register_registry[:B]
  when 6 then register_registry[:C]
  else raise 'You broke it dude'
  end
end

puts "Part 1: #{simulate_janky_computer(program, register_registry).join(', ').gsub(' ', '')}"


# # def is_this_going_to_break_my_laptops_memory(initial_b, initial_c, program)
# #   a = 2 ** program.length * 3
# #   step = 1

# #   loop do
# #     output = simulate_janky_computer(program, { A: a, B: initial_b, C: initial_c })
    
# #     matching_prefix = output.zip(program).take_while { |o, p| o == p }.length

# #     if matching_prefix == program.length
# #       puts "Full match found at A = #{a}"
# #       while true
# #         a -= 1
# #         output = simulate_janky_computer(program, { A: a, B: initial_b, C: initial_c })
# #         if output != program
# #           return a + 1
# #         end
# #       end
# #     elsif matching_prefix > 0
# #       puts "Partial match found, entering binary search"
# #       lower = a
# #       upper = a + step
# #       while lower < upper
# #         mid = (lower + upper) / 2
# #         puts "Binary search: Trying A = #{mid}"
# #         output = simulate_janky_computer(program, { A: mid, B: initial_b, C: initial_c })
# #         if output == program
# #           puts "Full match found in binary search at A = #{mid}"
# #           while true
# #             mid -= 1
# #             output = simulate_janky_computer(program, { A: mid, B: initial_b, C: initial_c })
# #             puts "Trying lower A = #{mid}, Output: #{output}"
# #             if output != program
# #               return mid + 1
# #             end
# #           end
# #         elsif output.zip(program).take_while { |o, p| o == p }.length >= matching_prefix
# #           upper = mid
# #         else
# #           lower = mid + 1
# #         end
# #       end
# #       a += 1
# #       step = 1
# #     else
# #       a += step
# #       step *= 2
# #       # step = (step * 1.5).to_i
# #     end
# #   end
# # end

# # def trying_to_do_this_3_bit_deal_wish_me_luck(output)
# #   # find every value between 0 and 7 that shares l
# # end

# # # puts "Part 2: #{is_this_going_to_break_my_laptops_memory(register_registry[:B], register_registry[:C], program)}"

# # def find_min_a_to_output_program(program)
# #   possibilities = [0]

# #   # Reverse sequence for correct evaluation
# #   program.reverse_each do |desired_output|
# #     new_possibilities = []
# #     possibilities.each do |current_value|
# #       (0..7).each do |x|
# #         potential_value = (current_value << 3) | x
# #         if potential_value % 8 == desired_output
# #           new_possibilities << potential_value
# #         end
# #       end
# #     end
# #     # Deduplicate to ensure we keep distinct feasible paths
# #     possibilities = new_possibilities.uniq
# #   end
# # p
# #   # Return the minimum of calculated possibilities, ideally the smallest A
# #   possibilities.min
# # end
# # puts "Part 2: 117440"

# # ***************************
# # def find_initial_a(program)
# #   bit_length = 0
# #   loop do
# #     (0...(2**bit_length)).each do |a|
# #       output = simulate_janky_computer(program, { A: a, B: 0, C: 0 })
# #       if output == program
# #         return a
# #       end
# #     end
# #     bit_length += 1
# #     puts "Searching numbers with #{bit_length} bits..."
# #   end
# # end
# # initial_a = find_initial_a(program)
# # puts "Part 2: #{initial_a}"
# # # ***************************

def last_try_then_bed(program)
  output_sequence = []

  # Process potential last states
  candidates = (0..7).map { |i| i * 8 }

  program.reverse_each do |expected_output|
    new_candidates = []
    candidates.each do |candidate|
      (0..7).each do |j|
        # The `j` here can be viewed as addresses or transformed bitwise accounts
        possible_value = (candidate << 3) + j
        if possible_value % 8 == expected_output
          new_candidates << possible_value
        end
      end
    end
    candidates = new_candidates.uniq
  end
  candidates.each do |candidate|
    puts "Candidate: #{candidate << 3}"
  end
  candidates.min
end

puts "Part 2: #{last_try_then_bed(program)}"
answer = simulate_janky_computer(program, { A: 130504923271952, B: 0, C: 0 })
puts "Testing: #{answer.join(', ').gsub(' ', '')}"

###### GPT1-o HELPED ME WITH EVERYTHING BELOW THIS LINE ######
# Function to extract operands from 'out' instructions
# def extract_out_outputs(program)
#   outputs = []
#   i = 0
#   while i < program.size
#     opcode = program[i]
#     operand = program[i + 1]
#     if opcode == 5 # 'out' opcode
#       # Determine operand value based on combo rules
#       case operand
#       when 0..3
#         value = operand
#       when 4
#         value = :A
#       when 5
#         value = :B
#       when 6
#         value = :C
#       else
#         raise "Invalid combo operand: #{operand}"
#       end
#       outputs << operand
#     end
#     i += 2
#   end
#   outputs
# end

# Function to compute the minimal A based on the sequence of outputs
def compute_minimal_A(outputs)
  sum = 0
  outputs.each_with_index do |output, i|
    sum += output * (8 ** i)
  end
  minimal_A = sum << 3
  minimal_A
end

# # Simulation Function (Simplified for Part 2)
# def simulate_janky_computer(program, register_registry, max_steps = 10**6)
#   ip = 0
#   output = []
#   steps = 0

#   while ip < program.size && steps < max_steps
#     instruction = program[ip]
#     operand = program[ip + 1] || 0

#     case instruction
#     when 0
#       # adv instruction
#       denominator = 2 ** get_combo_value(operand, register_registry)
#       register_registry[:A] = register_registry[:A] / denominator
#     when 1
#       # bxl instruction
#       register_registry[:B] ^= operand
#     when 2
#       # bst instruction
#       value = get_combo_value(operand, register_registry) % 8
#       register_registry[:B] = value
#     when 3
#       # jnz instruction
#       if register_registry[:A] != 0
#         ip = operand
#         steps += 1
#         next
#       end
#     when 4
#       # bxc instruction
#       register_registry[:B] ^= register_registry[:C]
#     when 5
#       # out instruction
#       value = get_combo_value(operand, register_registry) % 8
#       output << value
#     when 6
#       # bdv instruction
#       denominator = 2 ** get_combo_value(operand, register_registry)
#       register_registry[:B] = register_registry[:A] / denominator
#     when 7
#       # cdv instruction
#       denominator = 2 ** get_combo_value(operand, register_registry)
#       register_registry[:C] = register_registry[:A] / denominator
#     else
#       raise "Unknown opcode: #{instruction}"
#     end

#     # Logging each step for debugging
#     puts "Step #{steps}: IP=#{ip}, Opcode=#{instruction}, Operand=#{operand}, A=#{register_registry[:A]}, B=#{register_registry[:B]}, C=#{register_registry[:C]}, Output=#{output.last.inspect}"

#     ip += 2
#     steps += 1
#     break if output.length >= program.size
#   end

#   output
# end
# # Helper function to get the operand value based on combo rules
# def get_combo_value(operand, registers)
#   case operand
#   when 0..3
#     operand
#   when 4
#     registers[:A]
#   when 5
#     registers[:B]
#   when 6
#     registers[:C]
#   else
#     raise "Invalid combo operand: #{operand}"
#   end
# end

# # Main Execution Flow

# Read and parse the input file
lines = File.read('2024/day17/sample2.txt').split("\n")

register_registry = {}
program = []
lines.each do |line|
  register_pattern = /Register (\w+): (\d+)/
  match = register_pattern.match(line)
  if match
    register_registry[match[1].to_sym] = match[2].to_i
  end
  program_match = line.match(/Program: (.+)/)
  if program_match
    program = program_match[1].split(',').map(&:to_i)
  end
end


# Part 1: Simulate the program and collect outputs
part1_output = simulate_janky_computer(program, register_registry)
# puts "Part 1: #{part1_output.join(',')}"

# Part 2: Compute minimal A to output the program itself

# Extract the desired outputs (which should match the program's instruction list)
desired_outputs = program.dup

# Compute minimal A based on desired outputs
minimal_A = compute_minimal_A(desired_outputs) << 3
# puts "Computed minimal A: #{minimal_A}"

# Validate by simulating the program with computed minimal A
validation_registers = { A: minimal_A, B: 0, C: 0 }
produced_outputs = simulate_janky_computer(program, validation_registers)

# Check if produced outputs match the desired outputs
if produced_outputs == desired_outputs
  puts "Part 2: #{minimal_A}"
else
  puts "Validation Failed: Produced outputs do not match desired outputs."
  puts "Computed minimal A: #{minimal_A}"
  puts "Produced Outputs: #{produced_outputs.join(',')}"
  puts "Desired  Outputs: #{desired_outputs.join(',')}"
end

