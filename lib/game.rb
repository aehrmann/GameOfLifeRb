require 'terminal_display'

class Game

  attr_accessor :grid, :display

  def initialize(state_file_name, terminal_display = nil)
    @grid = load_grid_from_file(state_file_name)
    @display = terminal_display || TerminalDisplay.new
  end

  def run_loop
    until self.grid.empty?
      iterate_once
    end
  end

  def iterate_once
    display.pause
    display.clear_screen
    display.display_grid(self.grid)
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
