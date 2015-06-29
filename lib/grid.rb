class Grid
  attr_reader :locations
  def initialize
    @locations = {}
  end

  def spawn_cell_at(row, column)
    locations[[row, column]] = true
  end

  def kill_cell_at(row, column)
    locations[[row, column]] = false
  end

  def live_cell_at?(row, column)
    locations[[row, column]] == true
  end
end
