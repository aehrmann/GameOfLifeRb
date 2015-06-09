class World
  def initialize(dimension)
    @cells = Array.new(dimension) { Array.new(dimension, false) }
  end

  def living_cell?(x, y)
    @cells[y][x]
  end

  def spawn_cell_at(x, y)
    @cells[y][x] = true
  end
end
