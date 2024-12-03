# input = 'xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))'
# input = 'xmul(2,4)&mul[3,7]!^don\'t()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))'
input = File.read('2024/day3/input.txt')

def do_work_son(work)
  pattern = /mul\((\d{1,3}),(\d{1,3})\)/
  work.scan(pattern).map do |match|
    match[0].to_i * match[1].to_i
  end.sum
end

##########
# Part 1 #
##########

puts "Part 1: #{do_work_son(input)}"

##########
# Part 2 #
##########

def do_work_son_v2(work)
  mul_pattern = /mul\((\d{1,3}),(\d{1,3})\)/
  do_pattern = /do\(\)/
  dont_pattern = /don't\(\)/

  mul_on = true
  done_work = 0

  instructions = work.scan(/(mul\(\d{1,3},\d{1,3}\)|do\(\)|don't\(\))/)

  instructions.each do |instruction|
    case instruction.to_s
    when do_pattern
      mul_on = true
    when dont_pattern
      mul_on = false
    when mul_pattern
      if mul_on
        num1, num2 = instruction[0].scan(/\d+/).map(&:to_i)
        done_work += num1 * num2
      end
    end
  end

    done_work
end

puts "Part 2: #{do_work_son_v2(input)}"