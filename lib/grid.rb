require 'location'

Cell = Struct.new(:alive)

class Grid
  attr_reader :cells
  def initialize
    @cells = {}
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
    cells.values.none? { |cell| cell.alive }
  end

  def number_of_living_neighbors(location)
    location.neighboring_locations.reduce(0) do |count_living, location|
      count_living += 1 if live_cell_at?(location)
      count_living
    end
  end
end
