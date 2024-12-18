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


def is_this_going_to_break_my_laptops_memory(initial_b, initial_c, program)
  a = 2 ** program.length * 3
  step = 1

  loop do
    output = simulate_janky_computer(program, { A: a, B: initial_b, C: initial_c })
    
    matching_prefix = output.zip(program).take_while { |o, p| o == p }.length

    if matching_prefix == program.length
      puts "Full match found at A = #{a}"
      while true
        a -= 1
        output = simulate_janky_computer(program, { A: a, B: initial_b, C: initial_c })
        if output != program
          return a + 1
        end
      end
    elsif matching_prefix > 0
      puts "Partial match found, entering binary search"
      lower = a
      upper = a + step
      while lower < upper
        mid = (lower + upper) / 2
        puts "Binary search: Trying A = #{mid}"
        output = simulate_janky_computer(program, { A: mid, B: initial_b, C: initial_c })
        if output == program
          puts "Full match found in binary search at A = #{mid}"
          while true
            mid -= 1
            output = simulate_janky_computer(program, { A: mid, B: initial_b, C: initial_c })
            puts "Trying lower A = #{mid}, Output: #{output}"
            if output != program
              return mid + 1
            end
          end
        elsif output.zip(program).take_while { |o, p| o == p }.length >= matching_prefix
          upper = mid
        else
          lower = mid + 1
        end
      end
      a += 1
      step = 1
    else
      a += step
      step *= 2
      # step = (step * 1.5).to_i
    end
  end
end

# def trying_to_do_this_3_bit_deal_wish_me_luck(output)
#   # find every value between 0 and 7 that shares l
# end

# # puts "Part 2: #{is_this_going_to_break_my_laptops_memory(register_registry[:B], register_registry[:C], program)}"

# def find_min_a_to_output_program(program)
#   possibilities = [0]

#   # Reverse sequence for correct evaluation
#   program.reverse_each do |desired_output|
#     new_possibilities = []
#     possibilities.each do |current_value|
#       (0..7).each do |x|
#         potential_value = (current_value << 3) | x
#         if potential_value % 8 == desired_output
#           new_possibilities << potential_value
#         end
#       end
#     end
#     # Deduplicate to ensure we keep distinct feasible paths
#     possibilities = new_possibilities.uniq
#   end
# p
#   # Return the minimum of calculated possibilities, ideally the smallest A
#   possibilities.min
# end
# puts "Part 2: 117440"

# ***************************
# def find_initial_a(program)
#   bit_length = 0
#   loop do
#     (0...(2**bit_length)).each do |a|
#       output = simulate_janky_computer(program, { A: a, B: 0, C: 0 })
#       if output == program
#         return a
#       end
#     end
#     bit_length += 1
#     puts "Searching numbers with #{bit_length} bits..."
#   end
# end
# initial_a = find_initial_a(program)
# puts "Part 2: #{initial_a}"
# ***************************

def last_try_then_bed(program)
  a = 0
  multiplier = 1
  
  program.reverse.each_slice(2).with_index do |(operand, opcode), index|
    case opcode
    when 5  # out
      target = program[operand]
      a += target * multiplier
      multiplier *= 8
    when 0  # adv
      power = get_combo_meal(operand, {A: 0, B: 0, C: 0})
      multiplier *= 2 ** power
    end
  end

  a
end


puts "Part 2: #{last_try_then_bed(program)}"