require 'grid'

module GridBuilder
  def self.cells_from_initial_state(initial_state)
    cells = {}
    initial_state.each.with_index do |row, row_index|
      row.each_char.with_index do |char_value, column_index|
        location = Location.new(row_index, column_index)
        cells[location] = Cell.new(true) if char_value == '@'
        location.neighboring_locations.each do |neighboring_location|
          cells[neighboring_location] = Cell.new(false) if cells[neighboring_location].nil?
        end
      end
    end
    cells
  end
end
