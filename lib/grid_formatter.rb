class GridFormatter
  WIDTH = 60
  HEIGHT = 30

  TOP_OFFSET = (HEIGHT / 2) - 1
  LEFT_OFFSET = WIDTH / 2

  def self.as_string(grid)

    character_matrix = self.new_character_matrix 
    grid.cells.keys.each do |location|
      if grid.alive_at?(location)
        current_offset_row = location.row + TOP_OFFSET
        current_offset_column = location.column + LEFT_OFFSET
        if self.within_bounds?(current_offset_row, current_offset_column)
          character_matrix[current_offset_row][current_offset_column] = '@'
        end
      end
    end

    joined_display_string = character_matrix.map { |row| row.join('') }.join("\n")

     self.bar + joined_display_string + "\n" + self.bar
  end

  def self.bar
    ('=' * WIDTH) + "\n"
  end

  def self.empty_line
    '|' + ('-' * ( WIDTH - 2 )) + '|' + "\n"
  end

  def self.new_character_matrix
    (self.empty_line * HEIGHT).split("\n").map { |line| line.split(//) }
  end

  def self.within_bounds?(row, column)
    row < HEIGHT && column < WIDTH
  end

end
