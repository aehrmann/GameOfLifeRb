require 'location'
require 'grid_builder'

Cell = Struct.new(:alive)

class Grid

  attr_reader :cells

  def locations_to_update
    cells.keys.reduce([]) do |locations_to_update, location|
      locations_to_update << location if should_change_status?(location)
      locations_to_update
    end
  end

  def tick
    next_grid = self.copy
    
    locations_to_update.each do |location|
      next_grid.update_cell_at_location(location)
    end

    next_grid
  end

  def should_change_status?(location)
    if live_cell_at?(location)
      if underpopulated?(location) || overpopulated?(location)
        true
      end
    else
      if stable_population?(location)
        true
      end
    end

  end

  def update_cell_at_location(location)
    if live_cell_at?(location)
      add_dead_cell_at(location)
    else
      add_live_cell_at(location)
    end
  end

  def add_nonexistent_neighboring_locations(location)
    location.neighboring_locations.each do |neighboring_location|
      add_dead_cell_at(neighboring_location) if !cell_exists_at?(neighboring_location)
    end
  end

  class << self
    private :initialize
  end

  def initialize(cells = nil)
    @cells = cells || {}
  end

  def copy
    Grid.new(self.cells.dup)
  end

  def add_live_cell_at(location)
    cells[location] = Cell.new(true)
  end

  def add_dead_cell_at(location)
    cells[location] = Cell.new(false)
  end

  def live_cell_at?(location)
    cell_exists_at?(location) && cells[location].alive
  end

  def cell_exists_at?(location)
    !cells[location].nil?
  end

  def empty?
    number_of_living_cells == 0
  end

  def number_of_living_cells
    cells.values.count { |cell| cell.alive }
  end

  def number_of_living_neighbors(location)
    location.neighboring_locations.reduce(0) do |count_living, neighboring_location|
      count_living += 1 if live_cell_at?(neighboring_location)
      count_living
    end
  end


  private

  def underpopulated?(location)
    number_of_living_neighbors(location) < 2
  end

  def overpopulated?(location)
    number_of_living_neighbors(location) > 3
  end

  def stable_population?(location)
    number_of_living_neighbors(location) == 3
  end
end
