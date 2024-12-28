require 'digest'

input = File.read('2015/day4/input.txt').chomp
part_two = true
target = part_two ? '000000' : '00000'
i = 0

loop do
  i += 1
  break if Digest::MD5.hexdigest("#{input}#{i}").start_with?(target)
end

puts "Answer: #{i}"