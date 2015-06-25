class GridFormatter
  attr_reader :grid, :center_width

  def initialize(grid)
    @grid = grid
    @max_row = grid.locations.keys.max_by { |(row, _)| row }[0]
    @dimension_indexes = (0...@max_row)
  end

  def as_string
    bar + grid_display_string + bar
  end

  private

  def grid_header
    bar
  end

  def grid_footer
    bar
  end

  def grid_display_string
    @dimension_indexes.reduce("") do |string, row|
      string << string_for_row(row)
    end
  end

  def string_for_cell(row, col)
    last_column?(col) ? character_for_cell(row, col) : character_for_cell(row, col) + '-'
  end

  def last_column?(column)
    column + 1 == grid.dimension
  end

  def character_for_cell(row, col)
    cell = grid.cell_at(row, col)
    cell.alive? ? '@' : '-'
  end

  def string_for_row(row)
    '|' + string_for_grid_row(row) + '|' + "\n"
  end

  def string_for_grid_row(row)
    @dimension_indexes.reduce("") do |string, col|
      string << string_for_cell(row, col)
    end
  end

  def empty_lines(count)
    empty_line * count
  end

  def bar
    '=' * ((@max_row + 1) * 2) + "\n"
  end

end
