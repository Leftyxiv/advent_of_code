
# lines = File.readlines('sample.txt').map(&:chomp)

class Day4Puzzle

  def initialize
    @lines = File.readlines('sample.txt').map(&:chomp)
    @total = 0
    @cards_to_run = []
    @card_count = []
    @total_cards = {}
  end

  def do_stuff(cards)
    cards.each_with_index do |line, index|
      winning_numbers = {}
      winners = 0
      last_increment = 0
      after_bar = false
      next if line.nil?

      line = line.split(':')[1..2].to_s.split(' ')
      running_total = 0
      @total += 1
      line.each do |number|
        if after_bar
          if winning_numbers[number.to_i] == true
              if last_increment == 0
                running_total = 1
                last_increment = 1
                winning_numbers[number.to_i] = 1
              else
                running_total = (last_increment * 2)
                last_increment = last_increment * 2
                winning_numbers[number.to_i] = 1
              end
          end
        else
          if number == '|'
            after_bar = true
          else
            winning_numbers[number.to_i] = true
          end
        end
      end
      winning_numbers.each do |key, value|
        if value == 1 && key != 0
          winners += 1
        end
      end
      if @card_count[index + 1]
        @card_count[index + 1] += winners
      else
        @card_count[index + 1] = winners
      end
      # @card_count.to_a.each do |card, indy|
      #   (1..indy).step(1) do |step|
      #     @cards_to_run << index + step # @lines[index + step] unless @lines[index + step].nil?
      #     @total += 1
      #   end
      # end
      # @cards_to_run = []
      @card_count.each do |card|
        next if card.nil?

        (1..card).step(1) do |step|
          puts "index: #{index} step: #{step}"
          puts @lines[step + index].inspect
          @cards_to_run <<  @lines[step + index] unless @lines[step + index].nil? # @lines[index + step] unless @lines[index + step].nil?
          # puts @cards_to_run.inspect
          @total += 1
        end
      end
      puts @cards_to_run.length
      # puts @card_count.inspect
      # @total_cards[index + 1] = 1
      # puts @cards_to_run.inspect
    end
    # puts @card_count.inspect
    # @card_count.each do |card, count|
    #   (0..count - 1).step(1) do |step|
    #     @total_cards[step + card] += 1 if @total_cards[step + card]
    #     @total_cards[step + card] = 1 unless @total_cards[step + card]
    #   end
    # end
    # puts @total_cards.inspect
  end

  def run
    do_stuff(@lines)
    while @cards_to_run.length > 0

      if @total > 50
        break
      end
    end
    # iterate over the card count object
    # for each card, iterate over the number of cards
    # and add the card to the total ca
  #   @card_count.each do |card, count|
  #     (1..count).step(1) do |step|
  #       @total_cards[step + card] += 1
  #     end
  #   end
  # puts @card_count.inspect
  # puts @total_cards.inspect
  end
  # end
end

Day4Puzzle.new.run
# Part 1
# lines.each_with_index do |line, index|
#   winning_numbers = {}
#   last_increment = 0
#   after_bar = false
#   line = line.split(':')[1..2].to_s.split(' ')
#   running_total = 0
#   line.each do |number|
#     if after_bar
#       if winning_numbers[number.to_i] == true
#           if last_increment == 0
#             running_total = 1
#             last_increment = 1
#
# total = 0
# cards_to_run = []

# def do_stuff(cards)
#   cards.each_with_index do |line, index|
#     winning_numbers = {}
#     last_increment = 0
#     after_bar = false
#     line = line.split(':')[1..2].to_s.split(' ')
#     running_total = 0
#     line.each do |number|
#       if after_bar
#         if winning_numbers[number.to_i] == true
#             if last_increment == 0
#               running_total = 1
#               last_increment = 1
#               winning_numbers[number.to_i] = 1
#             else
#               running_total = (last_increment * 2)
#               last_increment = last_increment * 2
#               winning_numbers[number.to_i] = 1
#             end
#         end
#       else
#         if number == '|'
#           after_bar = true
#         else
#           winning_numbers[number.to_i] = true
#         end
#       end
#     end
#     winners = 0
#     winning_numbers.each do |key, value|
#       if value == 1 && key != 0
#         winners += 1
#       end
#     end
#     cards_to_run[index + 1] = winners
#   end
# end
# do_stuff(lines)

# while cards_to_run
#   new_cards_to_run = []
#   cards_to_run.each_with_index do |card, index|
#     next if card.nil?

#     [0..card].each_with_index do |num, indy|
#       new_cards_to_run << lines[index + indy + 1]
#     end
#   end
#   break
# end

# puts cards_to_run

# puts total
