# lines = """190: 10 19
# 3267: 81 40 27
# 83: 17 5
# 156: 15 6
# 7290: 6 8 6 15
# 161011: 16 10 13
# 192: 17 8 14
# 21037: 9 7 18 13
# 292: 11 6 16 20""".split("\n")
lines  = File.read('2024/day7/input.txt').split("\n")

numba_store = {}
lines.each do |line|
  numba, *rest = line.split(': ')
  numba = numba.to_i
  rest = rest[0].split(' ').map(&:to_i)
  numba_store[numba] = rest
end

part_two_warchest = {}

def find_numba(numba_to_get, numbaz_to_work_with, part_two_warchest)
  return false if numbaz_to_work_with.empty?

  maf_operators = ['+', '*'].repeated_permutation(numbaz_to_work_with.size - 1).to_a
  did_it_work = 0

  maf_operators.each do |operators|
    maf_to_do = []
    numbaz_to_work_with.each_with_index do |numba, index|
      maf_to_do << numba
      maf_to_do << operators[index] if operators[index]
    end

    maf_string = maf_to_do.join(' ')
    did_it_work = numbaz_to_work_with.first
    operators.each_with_index do |operator, index|
      if operator == '+'
        did_it_work += numbaz_to_work_with[index + 1]
      elsif operator == '*'
        did_it_work *= numbaz_to_work_with[index + 1]
      end
    end
    break if did_it_work == numba_to_get
  end
  part_two_warchest[numba_to_get] = numbaz_to_work_with if did_it_work != numba_to_get
  did_it_work == numba_to_get ? numba_to_get : 0
end

##########
# Part 1 #
##########

part_one = 0

numba_store.each do |numba, rest|
  part_one += find_numba(numba, rest, part_two_warchest)
end

puts "Part 1: #{part_one}"

##########
# Part 2 #
##########
part_two = 0

def find_numba_2(numba_to_get, numbaz_to_work_with)
  return false if numbaz_to_work_with.empty?

  maf_operators = ['+', '*', '||'].repeated_permutation(numbaz_to_work_with.size - 1).to_a

  maf_operators.each do |operators|
    maf_to_do = []
    numbaz_to_work_with.each_with_index do |numba, index|
      maf_to_do << numba
      maf_to_do << operators[index] if index < operators.length
    end

    current_value = numbaz_to_work_with.first.to_s

    operators.each_with_index do |operator, i|
      case operator
      when '+'
        current_value = current_value.to_i + numbaz_to_work_with[i + 1]
      when '*'
        current_value = current_value.to_i * numbaz_to_work_with[i + 1]
      when '||'
        current_value = current_value.to_s + numbaz_to_work_with[i + 1].to_s
      end
    end

    return numba_to_get if current_value.to_i == numba_to_get
  end

  0
end

part_two_warchest.each do |numba, rest|
  part_two += find_numba_2(numba, rest)
end

puts "Part 2: #{part_two + part_one}"