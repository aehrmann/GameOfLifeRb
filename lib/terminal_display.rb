require 'grid_formatter'
require 'io/console'

class TerminalDisplay
  def initialize
    @screen_rows, @screen_columns = IO.console.winsize
  end

  def display_grid(grid)
    $stdout.write GridFormatter.as_string(grid)
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
end

