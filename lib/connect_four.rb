require_relative './player'
require_relative './board'

class Game

  attr_accessor :board, :current_player, :other_player, :last_move
  def initialize(players, board = Board.new)
    @board = board
    @current_player = players[0]
    @other_player = players[1]
    @last_move = nil
  end

  def change_turn
    @current_player, @other_player = @other_player, @current_player
  end

  def prompt_player
    "#{current_player.name}: Enter a number from one of the available columns (1 - 7)"
  end

  def display_board
  end
  

  def get_move
    move_map = {
      '1' => 0,
      '2' => 1,
      '3' => 2,
      '4' => 3,
      '5' => 4,
      '6' => 5,
      '7' => 6
    }
    move = gets.chomp
    move_map[move]
  end

  def possible_move?(move)
    return true if board.grid[0][move] == ' '

    false
  end




  def game_over_message(previous_move)
    return "#{current_player.name} won!" if board.game_over?(previous_move) == :winner
    return 'The game ended in a draw' if board.game_over?(previous_move) == :draw
  end
  
  def play
    puts "#{current_player.name} has been selected as the first player"
    while true
      prompt_player
      move = nil
      loop do
        move = get_move
        break if possible_move?(move)
      end
      p move
      last_move = board.place_disc(move, current_player.disc)
      board.display_grid
      p test = last_move
      p board.game_over?(last_move)
      if board.game_over?(test) == :winner
        puts game_over_message(last_move)
        return
      else
        change_turn
      end
    end
  end

end

moe = Player.new({name: 'moe', disc: 'Y'})
rita = Player.new({name: 'rita', disc: 'R'})

test = Game.new([moe, rita])
p test.get_move
p test.play
