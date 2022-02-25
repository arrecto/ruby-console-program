# frozen_string_literal: true

# a class for Player
class Player
  attr_accessor :name, :symbol, :area

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @area = []
  end
end

# a class for Board
class Board
  @dot_separator = '.'
  @horizontal_line = '................'

  attr_accessor :square, :available_area

  def initialize
    @square = { '1' => 1, '2' => 2, '3' => 3,
                '4' => 4, '5' => 5, '6' => 6,
                '7' => 7, '8' => 8, '9' => 9 }
    @available_area = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def display_board
    puts "\n................"
    puts "  #{square['1']}  .  #{square['2']}  .  #{square['3']}"
    puts '................'
    puts "  #{square['4']}  .  #{square['5']}  .  #{square['6']}"
    puts '................'
    puts "  #{square['7']}  .  #{square['8']}  .  #{square['9']}\n\n"
  end
end

play_game = true
winning_combi = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                 [1, 4, 7], [2, 5, 8], [3, 6, 9],
                 [1, 5, 9], [3, 5, 7]]
loop do
  board = Board.new

  character_length_one = false
  puts 'Enter name of player 1: '
  player1 = gets.chomp

  until character_length_one
    puts "\nEnter single symbol/character to use for #{player1}"
    player1_symbol = gets.chomp
    character_length_one = true if player1_symbol.length == 1
  end

  puts "\nEnter name of player 2: "
  player2 = gets.chomp

  while character_length_one
    puts "\nEnter single symbol/character to use for #{player2}"
    player2_symbol = gets.chomp
    character_length_one = false if player2_symbol.length == 1
  end

  first_player = Player.new(player1, player1_symbol)
  second_player = Player.new(player2, player2_symbol)

  for i in 1..9

    player_name = ''
    position = 0

    if i.odd?
      player_name = first_player.name.to_s
    else
      player_name = second_player.name.to_s
    end

    puts "#{player_name} choose your position"
    board.display_board

    loop do
      position = gets.chomp
      if board.available_area.include?(position.to_i)
        board.available_area.delete(position.to_i)
        break
      end
    end

    counter = 0

    if i.odd?
      board.square[position] = first_player.symbol
      first_player.area.push(position.to_i)
      winning_combi.each do |k|
        counter = 0
        k.each do |j|
          counter += 1 if first_player.area.include?(j)
          if counter == 3
            puts "Congrats #{first_player.name}"
            break
          end
        end
        if counter == 3
          break
        end
      end
    else
      board.square[position] = second_player.symbol
      second_player.area.push(position.to_i)
      winning_combi.each do |k|
        counter = 0
        k.each do |j|
          counter += 1 if second_player.area.include?(j)
          if counter == 3
            puts "Congrats #{second_player.name}"
            break
          end
        end
        if counter == 3
          break
        end
      end
    end

    if counter == 3
      break
    end

    board.display_board
    board.available_area.delete(position.to_i)

  end

  puts "\nDo you want to play again? (y/n)"
  dec = gets.chomp
  if dec.downcase == 'y' || dec.downcase == 'yes'
    play_game = true
  else
    break
  end
end
