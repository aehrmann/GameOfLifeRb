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
    (0...dimension).each do |row|
      (0...dimension).each do |col|
        living_neighbors = cell_at(row, col).number_of_living_neighbors(self)
        if cell_at(row, col).alive?
          if living_neighbors < 2 || living_neighbors > 3
            results.push(cell_at(row, col))
          end
        else
          if living_neighbors == 3
            results.push(cell_at(row, col))
          end
        end
      end
    end
    results
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
