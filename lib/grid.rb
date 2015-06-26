class Grid
  attr_accessor :locations

  def cell_at(row, column)
    locations[[row, column]]
  end

  def spawn_cell_at(row, column)
    if cell_exists_at?(row, column)
      cell_at(row, column).live!
    else
      locations[[row, column]] = LivingCell.new(Location.new(row, column))
      add_neighbors_of(row, column)
    end
  end

  def add_neighbors_of(row, column)
    neighbor_locations_for_cell_at(row, column).each do |(neighbor_row, neighbor_col)|
      if !cell_exists_at?(neighbor_row, neighbor_col)
        locations[[neighbor_row, neighbor_col]] = DeadCell.new(Location.new(neighbor_row, neighbor_col))
      end
    end
  end

  def neighbor_locations_for_cell_at(row, column)
    cell_at(row, column).all_neighbor_index_pairs(row, column)
  end

  def cell_exists_at?(row, column)
    locations.has_key?([row, column])
  end

  def tick
    new_locations = locations.clone

    cells_to_update.each do |cell|
      if cell.alive?
        cell.die!
      else
        cell.live!
      end
      add_neighbors_of(cell.row, cell.col)
    end

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

  def initialize(locations = nil)
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
