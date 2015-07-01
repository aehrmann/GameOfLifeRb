require 'location'
require 'grid_builder'

Cell = Struct.new(:alive)

class Grid

  attr_reader :cells

  def locations_to_update
    locations_to_update = []
    cells.each_pair do |location, cell|
      if cell.alive
        if underpopulated?(location) || overpopulated?(location)
          locations_to_update << location
        end
      else
        if stable_population?(location)
          locations_to_update << location
        end
      end
    end
    locations_to_update
  end

  def tick
    next_grid = Grid.new(self.cells.dup)
    
    self.locations_to_update.each do |location|
      if self.live_cell_at?(location)
        next_grid.add_dead_cell_at(location)
        GridBuilder.add_nonexistent_neighboring_locations(self, location)
      else
        next_grid.add_live_cell_at(location)
        GridBuilder.add_nonexistent_neighboring_locations(self, location)
      end
    end
    next_grid
  end

  class << self
    private :initialize
  end

  def initialize(cells = nil)
    @cells = cells || {}
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
