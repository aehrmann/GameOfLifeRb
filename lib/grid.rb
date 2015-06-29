Location = Struct.new(:row, :column)

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
end
