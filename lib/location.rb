class Location
  NEIGHBOR_OFFSETS = [[-1, -1],[-1, 0],[-1, 1],
                      [0, -1],[0, 1],
                      [1, -1],[1, 0],[1, 1]]

  attr_reader :row, :column

  def initialize(row, column)
    @row, @column = row, column
  end

  def all_neighbor_locations
    NEIGHBOR_OFFSETS.map { |offset_pair| offset_location(offset_pair) }
  end

  def offset_location((row_offset, col_offset))
    Location.new(row + row_offset, column + col_offset)
  end

  def ==(other)
    self.row == other.row && self.column == other.column
  end
end
