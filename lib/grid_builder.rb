require 'grid'

module GridBuilder

  LIVING_CELL_CHARACTER = '@'

  def self.from_initial_state(initial_state)
    grid = Grid.new
    initial_state.each.with_index do |row, row_index|
      row.each_char.with_index do |cell_character, column_index|
        location = Location.new(row_index, column_index)
        grid.add_live_cell_at(location) if cell_character == LIVING_CELL_CHARACTER
        location.neighboring_locations.each do |neighboring_location|
          grid.add_dead_cell_at(neighboring_location) if !grid.cell_exists_at?(neighboring_location)
        end
      end
    end
    grid
  end

  def self.empty_grid
    Grid.new
  end
end
