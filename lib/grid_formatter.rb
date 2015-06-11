class GridFormatter
  attr_reader :grid
  def initialize(grid)
    @grid = grid
  end

  def as_string
    horizontal_padding = line_padding = 2
    grid_display_width = (3 * grid.dimension)

    s = ""

    s += separator(grid_display_width, horizontal_padding)
    s += vertical_padding(grid_display_width, line_padding)

    grid.cells.each.with_index do |row, row_index|
      s += row_display_string(row_index, horizontal_padding)
    end
    s += vertical_padding(grid_display_width, line_padding)
    s += separator(grid_display_width, horizontal_padding)
    s
  end

  def row_display_string(row, padding)
    s = ""
    s += row_start_string(padding)

    grid.cells[row].each.with_index do |col, col_index|
      s += cell_display_string(row, col_index)
    end

    s += row_end_string(padding)
    s
  end

  def row_start_string(padding)
    "|" + ("-" * padding)
  end

  def row_end_string(padding)
    ("-" * padding) + "-|\n"
  end

  def cell_display_string(row, col)
    grid.cell_at(row, col).alive? ? "-@" : "--"
  end

  def separator(width, padding)
    ("=" * (width + padding)) + "\n"
  end

  def vertical_padding(width, lines)
    padding_line(width) * lines
  end

  def padding_line(width)
    "|" + ("-" * width) + "|\n"
  end
end
