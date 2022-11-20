# frozen_string_literal: true

# tic_tac_toe.rb
# Tic tac toe game through terminal

class Board
  attr_accessor :board

  def initialize
    @board = [%w[_ _ _], %w[_ _ _], %w[_ _ _]]
  end

  def print_board
    puts ''
    @board.each do |square|
      puts square.join(' | ')
    end
    puts ''
  end

  def add_move(column, row, symbol)
    @board[column - 1][row - 1] = symbol
    print_board
  end

  def valid_move(array)
    if (array[0] - 1) > 2 || (array[0] - 1).negative?
      false
    elsif (array[1] - 1) > 2 || (array[1] - 1).negative?
      false
    else
      true
    end
  end

  def player_input
    puts 'Put in your move. | syntax: row,column | Range: 1-3'
    puts ''
    input = gets.chomp
    [input[0].to_i, input[2].to_i]
  end

  def position_taken(array)
    @board[array[0] - 1][array[1] - 1] != '_'
  end

  def symbol_picker(count)
    count.even? ? 'X' : 'O'
  end
end

class GameSession < Board
  def initialize
    @board = super
  end

  def start_game
    count = 0
    until game_end == true
      symbol = symbol_picker(count)
      input = valid_input
      add_move(input[0], input[1], symbol)
      count += 1
    end
    puts "Congratulations Player #{symbol_picker(count-1)}. You won!!"
    puts ''
  end

  def valid_input
    input = player_input
    while !valid_move(input) || position_taken(input)
      p 'Invalid move, try again'
      input = player_input
    end
    input
  end

  def game_end
    columns = [[@board[0][0], @board[1][0], @board[2][0]], [board[0][1], @board[1][1], @board[2][1]],
               [board[0][2], @board[1][2], @board[2][2]]]
    game_state = false
    columns.each { |column| column.count('X') == 3 || column.count('O') == 3 ? game_state = true : false }
    @board.each { |row| row.count('X') == 3 || row.count('O') == 3 ? game_state = true : false }
    game_state
  end
end

a = GameSession.new
a.start_game
