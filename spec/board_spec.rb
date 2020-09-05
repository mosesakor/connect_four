RSpec.configure do |config|
  config.example_status_persistence_file_path = 'spec/examples.txt'
end

RSpec.describe Board do

  context '#initialize' do
    it 'initializes the board with a grid' do
      expect { Board.new(grid: 'grid') }.to_not raise_error
    end

    it 'sets the grid to have seven rows by default' do
      board = Board.new
      expect(board.grid.size).to eq(6)
    end

    it 'sets the grid to have six columns by default' do
      board = Board.new
      board.grid.each do |column|
        expect(column.size).to eq(7)
      end
    end
  end

  context '#display_grid' do
    it 'displays the current state of the grid' do
      board = Board.new
      expect { board.display_grid }.to_not raise_error
    end
  end

  context '#place_disc' do
    it 'inserts a disc in the right coordinate' do
      board = Board.new
      board.place_disc(0, 'x')
      expected_output = [
        [' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' '],
        ['x', ' ', ' ', ' ', ' ', ' ', ' ']
      ]
      expect(board.grid).to eq(expected_output)
    end
  end

  context '#cross?' do
    it 'checks if there in a lineup along a given direction' do
      board = Board.new
      direction = [' ', 'x', 'nil', 'x', 'x', 'x', 'x']
      expect(board.cross?(direction)).to be_truthy
    end
  end

  context '#get_horizontal_line' do
    it 'gets creates a search space of seven fields horizontally' do
      board = Board.new
      search_space = board.get_horizontal_line([2, 3])
      expect(search_space.size).to eq(7)
    end
  end

  context '#horizontal_cross' do
    it 'checks if four similar discs line up horizontally' do
      grid = [
        [' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', 'x', 'x', 'x', 'x', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ']
      ]
      board = Board.new(grid: grid)
      expect(board.horizontal_cross?([2, 1])).to be_truthy
    end
  end

  context '#get_vertical_line' do
    it 'gets creates a search space of seven fields vertically' do
      board = Board.new
      search_space = board.get_vertical_line([2, 3])
      expect(search_space.size).to eq(7)
    end
  end

  context '#vertical_cross' do
    it 'checks if four similar discs line up vertically' do
      grid = [
        [' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', 'x', ' ', ' ', ' ', ' ', ' '],
        [' ', 'x', ' ', ' ', ' ', ' ', ' '],
        [' ', 'x', ' ', ' ', ' ', ' ', ' '],
        [' ', 'x', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ']
      ]
      board = Board.new(grid: grid)
      expect(board.vertical_cross?([1, 1])).to be_truthy
    end
  end

  context '#get_forward_diagonal_line' do
    it 'creates a search space of seven fields diagonally' do
      board = Board.new
      search_space = board.get_forward_diagonal_line([2, 3])
      expect(search_space.size).to eq(7)
    end
  end

  context '#forward_diagonal_cross' do
    it 'checks if four similar discs line up in a foward diagonal' do
      grid = [
        [' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', 'x', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', 'x', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', 'x', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', 'x', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ']
      ]
      board = Board.new(grid: grid)
      expect(board.forward_diagonal_cross?([1, 1])).to be_truthy
    end
  end

  context '#get_backward_diagonal_line' do
    it 'creates a search space of seven fields diagonally' do
      board = Board.new
      search_space = board.get_backward_diagonal_line([2, 3])
      expect(search_space.size).to eq(7)
    end
  end

  context '#backward_diagonal_cross' do
    it 'checks if four similar discs line up in a backward diagonal' do
      grid = [
        [' ', ' ', ' ', ' ', 'x', ' ', ' '],
        [' ', ' ', ' ', 'x', ' ', ' ', ' '],
        [' ', ' ', 'x', ' ', ' ', ' ', ' '],
        [' ', 'x', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ']
      ]
      board = Board.new(grid: grid)
      expect(board.backward_diagonal_cross?([0, 4])).to be_truthy
    end
  end

  context '#game_over' do
    it 'checks if the game is over' do
      grid = [
        [' ', ' ', ' ', ' ', 'x', ' ', ' '],
        [' ', ' ', ' ', 'x', ' ', ' ', ' '],
        [' ', ' ', 'x', ' ', ' ', ' ', ' '],
        [' ', 'x', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ']
      ]
      board = Board.new(grid: grid)
      expect(board.game_over?([0, 4])).to eq(:winner)
    end
  end
end

