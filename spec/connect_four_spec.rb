require 'spec_helper'


RSpec.describe Game do
  let (:moe) { Player.new({name: 'moe', disc: 'Y'}) }
  let (:rita) { Player.new({name: 'rita', disc: 'R'}) }

  context '#initialize' do
    it 'assigns a current player' do
      game = Game.new([moe, rita])
      expect(game.current_player).to eq(moe)
    end

    it 'assigns an other player' do
      game = Game.new([moe, rita])
      expect(game.other_player).to eq(rita)
    end
  end

  context '#change_turn' do
    it 'swaps the current player for the other player' do
      game = Game.new([moe, rita])
      game.change_turn
      expect(game.current_player).to eq(rita)
    end
  end

  context '#prompt_player' do
    it 'prompts the user for a move' do
      game = Game.new([moe, rita])
      expected = 'moe: Enter a number from one of the available columns (1 - 7)'
      expect(game.prompt_player).to eq(expected)
    end
  end

  context 'get_move' do
    xit 'gets a valid move from the player' do
      game = Game.new([moe, rita])
      expect { game.get_move }.to_not raise_error
    end
  end

  context 'possible_move' do
    it 'checks to see if a move is valid' do
      board1 = [
        ['x', ' ', ' ', ' ', ' ', ' ', ' '],
        ['x', ' ', ' ', ' ', ' ', ' ', ' '],
        ['x', ' ', ' ', ' ', ' ', ' ', ' '],
        ['x', ' ', ' ', ' ', ' ', ' ', ' '],
        ['x', ' ', ' ', ' ', ' ', ' ', ' '],
        ['x', ' ', ' ', ' ', ' ', ' ', ' ']
      ]
      game = Game.new([moe, rita])
      game.board.grid = board1

      expect(game.possible_move?(0)).to be_falsey
    end
  end
end
