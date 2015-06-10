class Grid
  attr_reader :dimension, :cells

  def living_cell?(row, column)
    within_bounds?(row, column) && cells[row][column]
  end

  def within_bounds?(row, column)
    row < dimension && row >= 0 && column < dimension && column >= 0
  end

  def spawn_cell_at(row, column)
    cells[row][column] = true
  end

  def tick
    new_cells = cells.clone

    cells_to_update.each { |(row, col)| new_cells[row][col] = !cells[row][col] }

    Grid.new(dimension, new_cells)
  end

  def cells_to_update
    results = []
    (0...dimension).each do |row|
      (0...dimension).each do |col|
        living_neighbors = count_living_neighbors(row, col)
        if living_cell?(row, col)
          if living_neighbors < 2 || living_neighbors > 3
            results += [[row, col]]
          end
        else
          if living_neighbors == 3
            results += [[row, col]]
          end
        end
      end
    end
    results
  end

  def count_living_neighbors(row, col)
    all_neighbor_coordinates(row, col).reduce(0) do |count, (row, col)|
      count += 1 if living_cell?(row, col)
      count
    end
  end

  def ==(other)
    self.cells == other.cells
  end

  def eql?(other)
    self == other
  end

  private

  def initialize(dimension, cells)
    @cells = cells
    @dimension = dimension
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
