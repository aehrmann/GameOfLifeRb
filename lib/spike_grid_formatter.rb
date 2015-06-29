class GridFormatter
  attr_reader :grid

  WIDTH = 60
  HEIGHT = 30

  ROW_OFFSET = HEIGHT / 2
  COL_OFFSET = WIDTH / 2

  def initialize(grid, grid_height = 0, grid_width = 0)
    @grid = grid
    @row_offset = ROW_OFFSET - grid_height
    @col_offset = COL_OFFSET - grid_width
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
      if row + @row_offset < HEIGHT && col + @col_offset < WIDTH
        matrix[row + @row_offset][col + @col_offset] = '@' if cell.alive
      end
    end

    joined_grid(matrix)
  end
end
