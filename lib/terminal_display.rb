require 'grid_formatter'
require 'io/console'

class TerminalDisplay

  GRID_WIDTH = 30

  def initialize
    @screen_rows, @screen_columns = IO.console.winsize
  end

  def display_grid(grid)
    $stdout.write GridFormatter.as_string(grid)
  end

  def display_number_of_generations(generations)
    $stdout.write with_left_padding('Generations: ' + generations.to_s) + "\n"
  end

  def display_number_of_living_cells(grid)
    $stdout.write with_left_padding('Living Cells: ' + grid.number_of_living_cells.to_s) + "\n"
  end

  def clear_screen
    display_clear_escape_code
    display_blank_screen
  end

  def display_clear_escape_code
    $stdout.write "\e[1;1H"
  end

  def display_blank_screen
    $stdout.write ((' ') * (@screen_columns)) * @screen_rows
  end

  def pause
    Kernel.sleep 0.1
  end

  private
  def with_left_padding(string)
    (' ' * (GRID_WIDTH - (string.length / 2))) + string
  end
end

