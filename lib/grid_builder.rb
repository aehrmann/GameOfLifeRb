require 'grid'

module GridBuilder

  LIVING_CELL_CHARACTER = '@'

  def self.from_initial_state(initial_state)
    grid = Grid.new

    self.with_location_character_pairs(initial_state) do |location, character|
      grid.set_living_at(location) if character == LIVING_CELL_CHARACTER
      grid.add_all_neighbor_locations_of(location)
    end

    grid.width = initial_state[0].length
    grid.height = initial_state.length

    grid
  end

  def self.empty_grid
    Grid.new
  end

  private

  def self.with_location_character_pairs(initial_state)
    initial_state.each.with_index do |row_string, row|
      row_string.each_char.with_index do |cell_character, column|
        yield(Location.new(row, column), cell_character)
      end
    end
  end

  def self.add_all_neighbor_locaitons(grid, location)
    location.neighboring_locations.each do |neighboring_location|
      grid.add_dead_cell_at(neighboring_location) if !grid.cell_exists_at?(neighboring_location)
    end
  end
end
