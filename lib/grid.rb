class Grid
  attr_reader :dimension, :cells, :locations

  def cell_at(row, column)
    locations[[row, column]]
  end

  def spawn_cell_at(row, column)
    cell = locations[[row, column]]
    cell.live!
  end

  def add_neighbors_of(row, column)
    cell_at(row, column).all_neighbor_index_pairs(row, column).each do |(neighbor_row, neighbor_col)|
      if !locations.has_key?([ neighbor_row, neighbor_col ])
        locations[[neighbor_row, neighbor_col]] = Cell.new(neighbor_row, neighbor_col, false)
      end
    end
  end

  def tick
    new_locations = locations.clone

    cells_to_update.each { |cell| cell.alive? ? cell.die! : cell.live! }

    Grid.new(new_locations)
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

  def each_cell
    locations.keys.each do |(row, col)|
      yield cell_at(row, col)
    end
  end

  def count_living_cells
    count = 0
    self.each_cell do |cell|
      count += 1 if cell.alive?
    end
    count
  end

  def all_cells_dead?
    self.each_cell do |cell|
      return false if cell.alive?
    end
    true
  end


  def ==(other)
    self.locations == other.locations
  end

  private

  def initialize(locations)
    @locations = locations
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
end
