require 'location'
require 'grid_builder'
require 'cell_rules'

class Grid

  Cell = Struct.new(:alive)

  attr_reader :cells, :rules
  attr_accessor :width, :height

  def initialize(cells = nil)
    @cells = cells || {}
    @rules = CellRules.new(self)
  end

  def next_generation
    next_grid = self.copy
    
    locations_to_update.each do |location|
      next_grid.update_cell_at_location(location)
    end

    next_grid.remove_irrelevant_locations

    next_grid
  end

  def copy
    grid = Grid.new(self.cells.dup)
    grid.width = self.width
    grid.height = self.height
    grid
  end

  def locations_to_update
    cells.keys.reduce([]) do |locations_to_update, location|
      locations_to_update << location if rules.should_change_status?(location)
      locations_to_update
    end
  end

  def add_all_neighbor_locations_of(location)
    location.neighboring_locations.each do |neighboring_location|
      set_dead_at(neighboring_location) if !alive_at?(neighboring_location)
    end
  end

  def remove_irrelevant_locations
    cells.each_key do |location|
      if number_of_living_neighbors(location) == 0
        cells.delete(location)
      end
    end
  end

  def update_cell_at_location(location)
    if alive_at?(location)
      set_dead_at(location)
    else
      set_living_at(location)
    end
    add_all_neighbor_locations_of(location)
  end

  def set_living_at(location)
    cells[location] = Cell.new(true)
  end

  def set_dead_at(location)
    cells[location] = Cell.new(false)
  end

  def alive_at?(location)
    exists_at?(location) && cells[location].alive
  end

  def exists_at?(location)
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
      count_living += 1 if alive_at?(neighboring_location)
      count_living
    end
  end

  def ==(other)
    self.cells == other.cells
  end
end
