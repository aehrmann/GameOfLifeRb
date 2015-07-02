require 'io/console'

class Game

  attr_accessor :grid

  def initialize(state_file_name)
    @grid = load_grid_from_file(state_file_name)
    @screen_rows, @screen_columns = IO.console.winsize
  end

  def run_loop
    until self.grid.empty?
      iterate_once
    end
  end

  def iterate_once
    sleep 0.3
    clear_and_display_grid
    self.grid = self.grid.tick
  end

  private

  def load_grid_from_file(file_name)
    initial_state = File.open(file_name).read().split("\n")
    GridBuilder.from_initial_state(initial_state)
  end

  def clear_and_display_grid
    puts (' ' * @screen_columns) * @screen_rows + "\n" + GridFormatter.as_string(self.grid)
  end
end
