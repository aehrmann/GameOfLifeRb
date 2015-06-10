class Cell
  NEIGHBOR_OFFSETS = [[-1, -1],[-1, 0],[-1, 1],
                      [0, -1],[0, 1],
                      [1, -1],[1, 0],[1, 1]]

  attr_reader :row, :col 

  def initialize(row, column, alive = false)
    @row, @col = row, column
    @alive = alive
  end

  def alive?
    @alive
  end

  def live!
    @alive = true
  end

  def die!
    @alive = false
  end

  def number_of_living_neighbors(grid)
    neighbor_index_pairs(grid).reduce(0) do |count, (row, col)|
      count += 1 if grid.cell_at(row, col).alive?
      count
    end
  end

  def neighbor_index_pairs(grid)
    all_neighbor_index_pairs(self.row, self.col).select do |(row, col)|
      within_bounds?(row, col, grid.dimension)
    end
  end

  def ==(other)
    self.row == other.row && self.col == other.col && self.alive? == other.alive?
  end

  private

  def within_bounds?(row, col, max_width)
      row >= 0 && row < max_width && col >= 0 && col < max_width
  end

  def all_neighbor_index_pairs(row, col)
    NEIGHBOR_OFFSETS.map { |offset_pair| offset_index_pair([row, col], offset_pair) }
  end

  def offset_index_pair((row, col), (row_offset, col_offset))
    [row + row_offset, col + col_offset]
  end

  def top_neighbor_index_pairs(row, col)
    [[row - 1, col - 1], [row - 1, col], [row - 1, col + 1]]
  end

  def side_neighbor_index_pairs(row, col)
    [[row, col - 1], [row, col + 1]]
  end

  def bottom_neighbor_index_pairs(row, col)
    [[row + 1, col - 1], [row + 1, col], [row + 1, col + 1]]
  end

end