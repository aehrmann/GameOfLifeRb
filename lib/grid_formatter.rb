class GridFormatter
  attr_reader :grid

  WIDTH = 60
  HEIGHT = 30

  ROW_OFFSET = HEIGHT / 2
  COL_OFFSET = WIDTH / 2

  def initialize(grid)
    @grid = grid
  end

  def blank_grid
    (('-' * WIDTH) + "\n") * HEIGHT
  end

  def blank_matrix
    blank_grid.split("\n").map { |line| line.split(//) }
  end

  def joined_grid(matrix)
    matrix.reduce("") do |result, row|
      result += row.join('') + "\n"
      result
    end
  end

  def as_string
    matrix = blank_matrix

    grid.locations.each_pair do |(row, col), cell|
      matrix[row + ROW_OFFSET][col + COL_OFFSET] = '@' if cell.alive?
    end

    joined_grid(matrix)
  end
end
