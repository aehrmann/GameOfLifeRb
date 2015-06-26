class Location
  NEIGHBOR_OFFSETS = [[-1, -1],[-1, 0],[-1, 1],
                      [0, -1],[0, 1],
                      [1, -1],[1, 0],[1, 1]]

  attr_reader :row, :column

  def initialize(row, column)
    @row, @column = row, column
  end

  def all_neighbor_index_pairs(location)
    NEIGHBOR_OFFSETS.map { |offset_pair| offset_index_pair([row, col], offset_pair) }
  end

  def offset_index_pair(location, (row_offset, col_offset))
    [row + row_offset, col + col_offset]
  end
end
