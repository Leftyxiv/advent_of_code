lines = File.readlines('input.txt').map(&:chomp)

# times = lines[0].split(': ')[1].split(' ').map(&:to_i)
times = [lines[0].split(': ')[1].gsub(' ', '').to_i]
# distances = lines[1].split(': ')[1].split(' ').map(&:to_i)
distances = [lines[1].split(': ')[1].gsub(' ', '').to_i]

total_strategies = []

times.each_with_index do |time, index|
  winning_strategies_per_time = []
  distance = 0
  (0..time).each do |t|
    hold_time = t
    time_remaining = time - t
    distance = hold_time * time_remaining
    # puts "time: #{time}, hold_time: #{hold_time}, time_remaining: #{time_remaining}, distance: #{distance}"
    winning_strategies_per_time << distance if distance > distances[index]
  end
  total_strategies << winning_strategies_per_time.length
end

total = 1
total_strategies.each do |strat|
  total *= strat
end
puts total