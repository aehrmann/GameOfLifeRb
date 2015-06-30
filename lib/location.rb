class Location
  NEIGHBOR_OFFSETS = [[-1, -1], [-1, 0], [-1, 1],
                      [0, -1], [0, 1],
                      [1, -1], [1, 0], [1, 1]]

  attr_reader :row, :column
  def initialize(row, column)
    @row, @column = row, column
  end

  def ==(other)
    self.row == other.row && self.column == other.column
  end

  alias eql? ==
  
  def hash
    self.row ^ self.column
  end

  def shift(row_offset, column_offset)
    Location.new(row + row_offset, column + column_offset)
  end

  def neighboring_locations
    NEIGHBOR_OFFSETS.map do |(row_offset, column_offset)|
      shift(row_offset, column_offset)
    end
  end

  def to_s
    "Location(#{row}, #{column})"
  end
end
