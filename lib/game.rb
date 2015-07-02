require 'io/console'

class Game

  attr_accessor :grid

  def initialize(state_file_name)
    @grid = load_grid_from_file(state_file_name)
    @screen_rows, @screen_columns = IO.console.winsize
  end

  def iterate_once
    clear_screen
    puts GridFormatter.as_string(self.grid)
    self.grid = self.grid.tick
  end

  private

  def load_grid_from_file(file_name)
    initial_state = File.open(file_name).read().split("\n")
    GridBuilder.from_initial_state(initial_state)
  end

  def clear_screen
    puts (' ' * @screen_columns) * @screen_rows + "\n"
  end
end
