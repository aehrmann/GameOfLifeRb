require 'location'

Cell = Struct.new(:alive)

class Grid
  attr_reader :cells
  def initialize(initial_state = nil)
    @cells = {}
    if initial_state
      initial_state.each.with_index do |row, row_index|
        row.each_char.with_index do |char_value, column_index|
          @cells[Location.new(row_index, column_index)] = Cell.new(true) if char_value == '@'
        end
      end
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
