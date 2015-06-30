require 'grid'

module GridBuilder

  LIVING_CELL_CHARACTER = '@'

  def self.from_initial_state(initial_state)
    cells = {}
    initial_state.each.with_index do |row, row_index|
      row.each_char.with_index do |char_value, column_index|
        self.add_cell_and_any_neighbors(row_index, column_index, char_value, cells)
      end
    end
    Grid.new(cells)
  end

  def self.empty_grid
    Grid.new
  end

  def self.add_cell_and_any_neighbors(row, column, character, cells)
    location = Location.new(row, column)
    cells[location] = Cell.new(true) if character == LIVING_CELL_CHARACTER
    location.neighboring_locations.each do |neighboring_location|
      cells[neighboring_location] = Cell.new(false) if cells[neighboring_location].nil?
    end
  end
  
end
