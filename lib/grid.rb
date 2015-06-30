require 'location'
require 'grid_builder'

Cell = Struct.new(:alive)

class Grid
  attr_accessor :cells
  def initialize(initial_state = nil)
    @cells = {}
    if initial_state
      @cells = GridBuilder.cells_from_initial_state(initial_state)
    end
  end

  def add_dead_cells_to_empty_neighbors(location)
    location.neighboring_locations.each do |neighboring_location|
      cells[neighboring_location] = Cell.new(false) if !cell_exists_at?(neighboring_location)
    end
  end
  def spawn_cell_at(location)
    cells[location] = Cell.new(true)
  end

  def kill_cell_at(location)
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
end
