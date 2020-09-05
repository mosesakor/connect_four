require 'pry'

class Board

  attr_accessor :grid, :available_coordinates
  def initialize(input = {})
    @grid = input.fetch(:grid, default_grid)
  end

  def display_grid
    row = 0
    while row < grid.size
      p grid[row]
      row += 1
    end
  end

  def place_disc(column, disc)
    row = 5
    while row >= 0
      if grid[row][column] == ' '
        grid[row][column] = disc
        return [row, column]
      end
      row -= 1
    end
  end

  def cross?(axis)
    count = 0
    prev = nil
  
    axis.each do |disc|
      if prev.nil?
        prev = disc
        count += 1
        next
      end
  
      if prev == disc
        count += 1
        return true if count == 4
        next
      end
  
      if prev != disc
        count = 1
      end
    end
    false
  end

  def valid_coordinate?(coordinate, i)
    return true if coordinate[1] + i >= 0 && coordinate[1] + i <= 7 &&
                  coordinate[0] + i <= 5 && coordinate[0] + i >= 0

    false
  end

  def get_horizontal_line(coordinate)
    i = -3
    possible_line = []
    while i <= 3
      if valid_coordinate?(coordinate, i)
        possible_line << [coordinate[0], coordinate[1] + i]
      end
      i += 1
    end
    possible_line.map { |coord| grid[coord[0]][coord[1]]}
  end

  def horizontal_cross?(coordinate)
    possible_line = get_horizontal_line(coordinate)
    cross?(possible_line)
  end

  def get_vertical_line(coordinate)
    i = -3
    possible_line = []
    while i <= 3
      if coordinate[0] + i >= 0 && coordinate[0] + i <= 5
        possible_line << [coordinate[0] + i, coordinate[1]]
      end
      i += 1
    end
    p possible_line
    p possible_line.map { |coord| grid[coord[0]][coord[1]]}.reverse
  end

  def vertical_cross?(coordinate)
    possible_line = get_vertical_line(coordinate)
    cross?(possible_line)
  end

  def get_forward_diagonal_line(coordinate)
    i = -3
    possible_line = []
    while i <= 3
      if valid_coordinate?(coordinate, i)
        possible_line << [coordinate[0] + i, coordinate[1] + i]
      end
      i += 1
    end
    possible_line.map { |coord| grid[coord[0]][coord[1]]}
  end

  def forward_diagonal_cross?(coordinate)
    possible_line = get_forward_diagonal_line(coordinate)
    cross?(possible_line)
  end

  def get_backward_diagonal_line(coordinate)
    i = -3
    possible_line = []
    while i <= 3
      if coordinate[0] - i <= 5 && coordinate[0] - i >= 0 && coordinate[1] + i <= 7 && coordinate[1] + i >= 0
        possible_line << [coordinate[0] - i, coordinate[1] + i]
      end
      i += 1
    end
    possible_line.map { |coord| grid[coord[0]][coord[1]]}
  end

  def backward_diagonal_cross?(coordinate)
    possible_line = get_backward_diagonal_line(coordinate)
    cross?(possible_line)
  end

  def grid_filled?
    return true if !grid[0].include?(' ')
  end

  def game_over?(coordinate)
    if vertical_cross?(coordinate) || horizontal_cross?(coordinate) ||
      forward_diagonal_cross?(coordinate) || backward_diagonal_cross?(coordinate)
      :winner
    elsif grid_filled?
      :draw
    else
      false
    end
  end

  def default_grid
    Array.new(6) { Array.new(7) { ' ' } }
  end

end

test = Board.new
test.place_disc(3, "x")
test.place_disc(3, "y")
test.horizontal_cross?([4, 6])
