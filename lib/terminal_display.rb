require 'grid_formatter'
require 'io/console'

class TerminalDisplay
  def initialize
    @screen_rows, @screen_columns = IO.console.winsize
  end

  def clear_and_display_grid(grid)
    display_blank_screen
    display_grid
    clear_screen
  end

  def display_grid(grid)
    $stdout.write GridFormatter.as_string(grid)
  end

  def display_blank_screen
    $stdout.write ((' ') * (@screen_columns)) * @screen_rows
  end

  def clear_screen
   $stdout.write "\e[1;1H"
  end
end

