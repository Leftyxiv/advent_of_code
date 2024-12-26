require 'set'

def mix(secret, value)
  secret ^ value
end

def prune(secret, modulo)
  secret % modulo
end

def do_secret_number(secret, operation, prune_modulo = 16_777_216)
  case operation
  when :step1
    number = secret * 64
  when :step2
    number = secret / 32
  when :step3
    number = secret * 2048
  end

  number = mix(secret, number)
  number = prune(number, prune_modulo)
  number
end

##########
# part 1 #
##########

inputs = File.read('2024/day22/sample.txt').split("\n").map(&:to_i)

part_two_naners_testing_obj = Hash.new { |h, k| h[k] = [] }
outputs = []
inputs.each do |input|
  secret = input
  highest_price = nil
  part_two_naners_testing_obj[input] << secret
  (0..5).each do
    [:step1, :step2, :step3].each do |operation|
      secret = do_secret_number(secret, operation)
      part_two_naners_testing_obj[input] << secret
    end
  end
  outputs << secret
end

puts "Part 1: #{outputs.sum}"

##########
# part 2 #
##########

price_changes = []
def extract_prices(bids)
  bids.map { |bid| bid % 10 }
end

part_two_naners_testing_obj.each do |input, secrets|
  prices = extract_prices(secrets)
  price_changes << prices
end

def calculate_prices(price_changes)
  price_changes.map do |prices|
    prices.each_cons(2).map do |price1, price2|
      price2 - price1
    end
  end
end

sequence_totals = Hash.new(0)

differences = calculate_prices(price_changes)

seen_sequences = Set.new

(0..differences.length - 4).each do |i|
  seq = differences[i, 4].join(',')
  next if seen_sequences.include?(seq)
  
  seen_sequences.add(seq)
  
  this_price = differences[i + 4]
  # puts "Sequence: #{seq}, Price: #{this_price}"
  puts "difference: #{differences[i, 4]}"
  sequence_totals[seq] += this_price
end

optimal_sequence, max_total = sequence_totals.max_by { |_, total| total }

puts "Part 2: #{max_total}"