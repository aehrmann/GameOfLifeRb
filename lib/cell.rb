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
    all_neighbor_index_pairs(self.row, self.col).reduce(0) do |count, (row, col)|
      cell = grid.cell_at(row, col)
      if !cell.nil?
        count += 1 if cell.alive?
      end
      count
    end
  end

  def ==(other)
    self.row == other.row && self.col == other.col && self.alive? == other.alive?
  end

  def all_neighbor_index_pairs(row, col)
    NEIGHBOR_OFFSETS.map { |offset_pair| offset_index_pair([row, col], offset_pair) }
  end

  private

  def within_bounds?(row, col, max_width)
      row >= 0 && row < max_width && col >= 0 && col < max_width
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
