class Game

  attr_accessor :grid

  def initialize(state_file_name)
    @grid = load_grid_from_file(state_file_name)
  end

  def iterate_once
    puts GridFormatter.as_string(self.grid)
    self.grid = self.grid.tick
  end

  private

  def load_grid_from_file(file_name)
    initial_state = File.open(file_name).read().split("\n")
    GridBuilder.from_initial_state(initial_state)
  end
end
