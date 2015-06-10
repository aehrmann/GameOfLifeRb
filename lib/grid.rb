class Grid
  attr_reader :dimension, :cells

  def cell_at(row, column)
    cells[row][column]
  end

  def spawn_cell_at(row, column)
    cells[row][column].live!
  end

  def tick
    new_cells = cells.clone

    cells_to_update.each { |cell| cell.alive? ? cell.die! : cell.live! }

    Grid.new(dimension, new_cells)
  end

  def cells_to_update
    results = []
    self.each_cell do |cell|
      if cell.alive?
        results.push(cell) if overpopulated?(cell) || underpopulated?(cell)
      else 
        results.push(cell) if can_reproduce?(cell)
      end
    end
    results
  end

  def overpopulated?(cell)
    cell.number_of_living_neighbors(self) > 3
  end

  def underpopulated?(cell)
    cell.number_of_living_neighbors(self) < 2
  end

  def can_reproduce?(cell)
    cell.number_of_living_neighbors(self) == 3
  end

  def each_cell
    (0...dimension).each do |row|
      (0...dimension).each do |col|
        yield cell_at(row, col)
      end
    end
  end

  def ==(other)
    self.cells == other.cells
  end

  private

  def initialize(dimension, cells)
    @cells = cells
    @dimension = dimension
  end
end
