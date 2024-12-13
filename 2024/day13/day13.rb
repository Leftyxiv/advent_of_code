lines = File.read('2024/day13/input.txt').split("\n\n")

buttons_n_stuff = {}
BUTTON_A_COST = 3
BUTTON_B_COST = 1

lines.each do |line|
  parts = line.split("\n")

  a_button = parts[0].scan(/[-]?\d+/).map(&:to_i)
  b_button = parts[1].scan(/[-]?\d+/).map(&:to_i)
  prize = parts[2].scan(/[-]?\d+/).map(&:to_i)

  buttons_n_stuff[[prize[0], prize[1]]] = { :a => a_button, :b => b_button }
end

##########
# Part 1 #
##########

def go_win_stuff(prize, a_button, b_button)
  prizeX, prizeY = prize
  a_buttonX, a_buttonY = a_button
  b_buttonX, b_buttonY = b_button
  if a_buttonX > b_buttonX * 3
    max_a_times = prizeX / a_buttonX
    return nil if max_a_times > 100
    while max_a_times > 0
      difference = prizeX - (a_buttonX * max_a_times)
      if difference % b_buttonX == 0
        max_b_times = difference / b_buttonX
        return max_a_times * BUTTON_A_COST + max_b_times * BUTTON_B_COST
      else
        max_a_times -= 1
      end
    end

  else
    max_b_times = prizeX / b_buttonX
    return nil if max_b_times > 100
    while max_b_times > 0
      difference = prizeX - (b_buttonX * max_b_times)
      if difference % a_buttonX == 0
        max_a_times = difference / a_buttonX
        return max_a_times * BUTTON_A_COST + max_b_times * BUTTON_B_COST
      else
        max_b_times -= 1
      end
    end
  end
  nil
end

part_one = 0
buttons_n_stuff.each do |prize, buttons|
  cost = go_win_stuff(prize, buttons[:a], buttons[:b])
  part_one += cost if cost
end
puts "Part 1: #{part_one}"

##########
# Part 2 #
##########

# thanks for the tip redditors never heard of z3 before
def solve_z3(ax, ay, bx, by, px, py)
  require 'z3'
  solver = Z3::Solver.new
  a = Z3.Int('a')
  b = Z3.Int('b')

  solver.assert(a >= 0)
  solver.assert(b >= 0)
  solver.assert(ax * a + bx * b == px)
  solver.assert(ay * a + by * b == py)

  return nil unless solver.satisfiable?

  [solver.model[a].to_i, solver.model[b].to_i]
end

def get_claw_machines(buttons_n_stuff)
  buttons_n_stuff.map do |prize_coords, buttons|
    {
      prize: prize_coords,
      A: buttons[:a],
      B: buttons[:b]
    }
  end
end

def go_win_stuff_part_2(buttons_n_stuff)
  get_claw_machines(buttons_n_stuff).map { |g|
  g[:prize][0] += 10_000_000_000_000
  g[:prize][1] += 10_000_000_000_000

    s = solve_z3(*g[:A], *g[:B], *g[:prize])
    3*s[0] + s[1] if s
  }.compact.sum
end

puts "Part 2: #{go_win_stuff_part_2(buttons_n_stuff)}"
