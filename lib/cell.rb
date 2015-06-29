require_relative './location'

class Cell
  NEIGHBOR_OFFSETS = [[-1, -1],[-1, 0],[-1, 1],
                      [0, -1],[0, 1],
                      [1, -1],[1, 0],[1, 1]]

  attr_reader :row, :col 

  def initialize(row, column)
    @row, @col = row, column
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
      cell = grid.locations[ [ row, col ] ]
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

  def offset_index_pair((row, col), (row_offset, col_offset))
    [row + row_offset, col + col_offset]
  end

end

class LivingCell < Cell
  #def initialize(location)
    #_initialize(location.row, location.column)
  #end

  def initialize(row, column)
    @row, @col = row, column
    @alive = true
  end
  def to_s
    "[Alive - (#{row}, #{col})]"
  end
end

class DeadCell < Cell
  #def initialize(location)
    #_initialize(location.row, location.column)
  #end

  def initialize(row, column)
    @row, @col = row, column
    @alive = false
  end

  def to_s
    "[Dead - (#{row}, #{col})]"
  end
end
