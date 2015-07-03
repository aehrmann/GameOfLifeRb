require 'grid_formatter'
require 'io/console'

class TerminalDisplay
  def initialize
    @screen_rows, @screen_columns = IO.console.winsize
  end

  def clear_and_display_grid(grid)
    $stdout.write (blank_screen_string + GridFormatter.as_string(grid) + clear_screen_escape_code)
  end

  def blank_screen_string
    ((' ') * (@screen_columns)) * @screen_rows
  end

  def clear_screen_escape_code
    "\e[1;1H"
  end
end

