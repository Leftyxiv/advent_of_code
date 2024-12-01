lines = File.readlines('input.txt').map(&:chomp)

def check_hand(hand)
  cards = {}
  pairs = []
  hand.chars.each do |card|
    cards[card] ||= 0
    cards[card] += 1
  end
  cards.each do |card, count|
    pairs << count
  end
  if pairs == [5]
    return 7
  elsif pairs.sort == [1, 4]
    return cards['J'] && cards['J'] > 0 ? 7 : 6 
  elsif  pairs.sort == [2, 3]
    if cards['J'] && cards['J'] > 0
      return 7
    else
      return 5
    end
  elsif pairs.sort == [1, 1, 3]
    if cards['J'] == 3
      return 6
    elsif cards['J'] == 1
      return 6
    else
      return 4
    end
  elsif pairs.sort == [1, 2, 2]
    if cards['J'] == 2
      return 6
    elsif cards['J'] == 1
      return 5
    else
      return 3
    end
  elsif pairs.sort == [1, 1, 1, 2]
    if cards['J'] == 2 || cards['J'] == 1
      return 4
    else
      return 2
    end
  else
    if cards['J'] == 1
      return 2
    end
    return 1
  end
end

card_scores = {
  'A' => 14,
  'K' => 13,
  'Q' => 12,
  # 'J' => 11,
  'J' => 0,
  'T' => 10,
  '9' => 9,
  '8' => 8,
  '7' => 7,
  '6' => 6,
  '5' => 5,
  '4' => 4,
  '3' => 3,
  '2' => 2,
  '1' => 1
}


all_hands = []
lines.each do |line|
  hand, bid = line.split(' ')
  rank = check_hand(hand)
  all_hands << [hand, bid, rank]
end

all_hands.sort_by! { |hand| -hand[2] }

all_hands.sort! do |a, b|
  bigger = -50
  if a[2] == b[2]
    a[0].chars.each_with_index do |c, i|
      if a[0][i] == b[0][i]
        next
      else
        bigger = card_scores[a[0][i]] <=> card_scores[b[0][i]]
        break
      end
    end
  else
    bigger = a[2] <=> b[2]
  end
  -bigger
end

winnings = 0
all_hands.reverse.each_with_index do |hand, index|
  winnings += hand[1].to_i * (index + 1)
end

puts winnings

