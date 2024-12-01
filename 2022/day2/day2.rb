# lines = """A Y
# B X
# C Z""".split("\n")


lines = File.read('2022/day2/input.txt').split("\n")

OPPONENTS = {
  'A' => :rock,
  'B' => :paper,
  'C' => :scissors
}

MY_MOVES = {
  'y' => :paper,
  'x' => :rock,
  'z' => :scissors
}

SCORE = {
  :rock => 1,
  :paper => 2,
  :scissors => 3
}

WIN_HIEARCHY = {
  :rock => :scissors,
  :paper => :rock,
  :scissors => :paper
}

def do_score(opponent, me)
 if WIN_HIEARCHY[opponent] == me
   return SCORE[me]
 elsif WIN_HIEARCHY[me] == opponent
   return SCORE[me] + 6
 else
   return SCORE[me] + 3
 end
end

##########
# Part 1 #
##########

total = 0
lines.each do |line|
  opponent, me = line.split
  total += do_score(OPPONENTS[opponent], MY_MOVES[me.downcase])
end
puts "Part 1: #{total}"

##########
# Part 2 #
##########

PART_TWO_SCHEMA = {
  'X' => :lose,
  'Y' => :draw,
  'Z' => :win
}

part_two_total = 0
lines.each do |line|
  opponent, me = line.split
  opponent = OPPONENTS[opponent]
  my_play = PART_TWO_SCHEMA[me]
  if my_play == :win
    part_two_total += SCORE[WIN_HIEARCHY.key(opponent)] + 6
  elsif my_play == :draw
    part_two_total += SCORE[opponent] + 3
  else
    part_two_total +=  SCORE[WIN_HIEARCHY[opponent]]
  end
end
puts "Part 2: #{part_two_total}"