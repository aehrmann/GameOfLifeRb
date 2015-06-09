class World
  def initialize(dimension)
    @cells = Array.new(dimension) { Array.new(dimension, false) }
  end

  def living_cell?(row, column)
    @cells[row][column]
  end

  def spawn_cell_at(row, column)
    @cells[row][column] = true
  end

  def count_living_neighbors(row, col)
    all_neighbor_coordinates(row, col).reduce(0) do |count, (row, col)|
      count += 1 if living_cell?(row, col)
      count
    end
  end

  def all_neighbor_coordinates(row, col)
    top_neighbor_coordinates(row, col) +
    side_neighbor_coordinates(row, col) +
    bottom_neighbor_coordinates(row, col)
  end

  def top_neighbor_coordinates(row, col)
    [[row - 1, col - 1], [row - 1, col], [row - 1, col + 1]]
  end

  def side_neighbor_coordinates(row, col)
    [[row, col - 1], [row, col + 1]]
  end

  def bottom_neighbor_coordinates(row, col)
    [[row + 1, col - 1], [row + 1, col], [row + 1, col + 1]]
  end
end
