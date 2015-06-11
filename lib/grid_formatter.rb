class GridFormatter
  HORIZONTAL_PADDING = 4
  VERTICAL_LINE_PADDING = 2

  attr_reader :grid, :center_width

  def initialize(grid)
    @grid = grid
    @center_width = (grid.dimension * 2) - 1
    @dimension_indexes = (0...grid.dimension)
  end

  def as_string
    grid_header + grid_display_string + grid_footer
  end

  private

  def grid_header
    bar + empty_lines(VERTICAL_LINE_PADDING)
  end

  def grid_footer
    empty_lines(VERTICAL_LINE_PADDING) + bar
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
    grid.cell_at(row, col).alive? ? '@' : '-'
  end

  def string_for_row(row)
    row_left + string_for_grid_row(row) + row_right + "\n"
  end

  def string_for_grid_row(row)
    @dimension_indexes.reduce("") do |string, col|
      string << string_for_cell(row, col)
    end
  end

  def row_right
    ('-' * HORIZONTAL_PADDING) + '|'
  end

  def row_left
    '|' + ('-' * HORIZONTAL_PADDING) 
  end

  def empty_lines(count)
    empty_line * count
  end

  def empty_line
    '|' + ('-' * HORIZONTAL_PADDING) + ('-' * center_width) + ('-' * HORIZONTAL_PADDING) + '|' + "\n"
  end

  def bar
    '=' * ((2 * grid.dimension) + (HORIZONTAL_PADDING * 2) + 1) + "\n"
  end

end
