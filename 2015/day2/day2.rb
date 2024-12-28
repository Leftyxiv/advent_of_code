
# 2*l*w + 2*w*h + 2*h*l + smallest side
inputs = File.read('2015/day2/input.txt').split("\n")

prisms = []
regex = /(\d+)x(\d+)x(\d+)/

inputs.each do |input|
    prisms << input.scan(regex).flatten.map(&:to_i)
end

total = 0
ribbon_feet = 0
prisms.each do |prism|
    l, w, h = prism
    sides = [l*w, w*h, h*l]
    total += 2*sides.sum + sides.min
    ribbon_feet += [l, w, h].min(2).sum*2 + l*w*h
end

puts "Part 1: #{total}"
puts "Part 2: #{ribbon_feet}"