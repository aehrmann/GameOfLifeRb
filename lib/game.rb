require 'terminal_display'

class Game

  attr_accessor :grid, :display, :generations

  def initialize(state_file_name, terminal_display = nil)
    @grid = load_grid_from_file(state_file_name)
    @display = terminal_display || TerminalDisplay.new
    @generations = 0
  end

  def run_loop
    display_current_information_and_grid
    begin
      until self.grid.empty?
        iterate_once
      end
    rescue Interrupt
      puts "Goodbye!"
    end
  end

  def iterate_once
    @generations += 1
    self.grid = self.grid.next_generation
    display.pause
    display.clear_screen
    display_current_information_and_grid
  end

  private

  def display_current_information_and_grid
    display.display_number_of_generations(generations)
    display.display_number_of_living_cells(grid)
    display.display_grid(grid)
  end


  def load_grid_from_file(file_name)
    initial_state = File.open(file_name).read().split("\n")
    GridBuilder.from_initial_state(initial_state)
  end
end
