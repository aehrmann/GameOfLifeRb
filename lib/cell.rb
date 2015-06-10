class Cell
  NEIGHBOR_OFFSETS = [[-1, -1],[-1, 0],[-1, 1],
                      [0, -1],[0, 1],
                      [1, -1],[1, 0],[1, 1]]

  attr_reader :row, :col 

  def initialize(row, column)
    @row, @col = row, column
    @alive = false
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

  def neighbor_index_pairs(max_width)
    all_neighbor_index_pairs(self.row, self.col).select do |(row, col)|
      within_bounds?(row, col, max_width)
    end
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
