class MockTerminalDisplay
  attr_reader :display_grid_was_called,
              :clear_screen_was_called,
              :pause_was_called,
              :display_number_of_living_cells_was_called

  def initialize
    @display_grid_was_called = false
    @clear_screen_was_called = false
    @pause_was_called = false
    @display_number_of_living_cells_was_called = false
  end

  def display_grid(grid)
    @display_grid_was_called = true
  end

  def display_number_of_living_cells(grid)
    @display_number_of_living_cells_was_called = true
  end

  def clear_screen
    @clear_screen_was_called = true
  end

  def pause
    @pause_was_called = true
  end
end

