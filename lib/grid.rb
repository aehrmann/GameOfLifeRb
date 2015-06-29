Location = Struct.new(:row, :column) do
  def shift(row_offset, column_offset)
    Location.new(row + row_offset, column + column_offset)
  end
end

class Grid
  attr_reader :locations
  def initialize
    @locations = {}
  end

  def spawn_cell_at(location)
    locations[location] = true
  end

  def kill_cell_at(location)
    locations[location] = false
  end

  def live_cell_at?(location)
    locations[location] == true
  end

  def cell_exists_at?(location)
    !locations[location].nil?
  end

  def number_of_living_neighbors(location)
    living_neighbors = 0
    neighboring_locations(location).each do |locations|
      locations.each { |location| living_neighbors += 1 if live_cell_at?(location) }
    end
    living_neighbors
  end

  private

  def neighboring_locations(location)
    top_neighbors = [location.shift(-1, -1),
                     location.shift(-1, 0),
                     location.shift(-1, 1)]

    side_neighbors = [location.shift(0, -1),
                      location.shift(0, 1)]

    bottom_neighbors = [location.shift(1, -1),
                        location.shift(1, 0),
                        location.shift(1, 1)]
    [top_neighbors, side_neighbors, bottom_neighbors]
  end
end
