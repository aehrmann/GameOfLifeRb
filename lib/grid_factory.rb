require_relative 'cell'
require_relative 'grid'

module GridFactory

  class ImproperFormatError < StandardError; end

  def self.from_parsed_input(contents)
    string_array = contents.split("\n").map { |line| line.strip }
    self.from_string_array(string_array)
  end

  def self.from_string_array(string_array)
    new_cells = string_array.map.with_index do |string, row|
      string.each_char.map.with_index { |char, col| Cell.new(row, col, char == '@') }
    end

    Grid.new(string_array.length, new_cells)
  end

  def self.empty_grid(dimension)
    empty_matrix = Array.new(dimension) { Array.new(dimension) }

    cells = empty_matrix.map.with_index do |row, row_index|
      empty_matrix[row_index].map.with_index do |cell_value, col_index|
        Cell.new(row_index, col_index)
      end
    end

    Grid.new(dimension, cells)
  end
end
