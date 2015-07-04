require 'terminal_display'

class Game

  attr_accessor :grid

  def initialize(state_file_name)
    @grid = load_grid_from_file(state_file_name)
    @display = TerminalDisplay.new
  end

  def run_loop
    until self.grid.empty?
      iterate_once
    end
  end

  def iterate_once
    sleep 0.1
    clear_and_display_grid
    self.grid = self.grid.next_generation
  end

  private

  def load_grid_from_file(file_name)
    initial_state = File.open(file_name).read().split("\n")
    GridBuilder.from_initial_state(initial_state)
  end

  def clear_and_display_grid
    @display.clear_and_display_grid(grid)
  end
end
