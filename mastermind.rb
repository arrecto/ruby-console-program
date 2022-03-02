# frozen_string_literal: true

# class for mystery number
class Mystery
  attr_reader :secret_combi, :name
  attr_accessor :player_guess, :correct_guess

  def initialize(name)
    @random_num = (rand * 10_000).to_i.to_s.split('')
    @secret_combi = @random_num.map { |i| i.to_i }
    @name = name
    @correct_guess = 0
  end

  def correct_num_wrong_place
    print '0'
  end

  def wrong_num
    print 'X'
  end

  def correct_num
    print '/'
  end

  def check_guess(guess)
    @player_guess = guess.split('')
    @player_guess.map! { |i| i.to_i }

    @player_guess.each_with_index do |i, x|
      if @secret_combi.include?(i)
        if @secret_combi[x] == @player_guess[x]
          correct_num
          @correct_guess += 1
          next
        end
        correct_num_wrong_place
      else
        wrong_num
      end
    end
  end
end

play_game = true

while play_game
  puts 'Enter name: '
  player_name = gets.chomp
  game = Mystery.new(player_name)

  win = false

  until win
    print "\nEnter 4-digit number:"
    guess = gets.chomp
    game.check_guess(guess)

    if game.correct_guess == 4
      win = true
      break
    end

    game.correct_guess = 0
  end

  play_game = false

end
