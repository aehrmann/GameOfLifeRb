require 'cell'
require 'grid'

module GridFactory

  class ImproperFormatError < StandardError; end

  def self.from_string_array(string_array)
    if string_array.any? { |str| str.gsub(/,/, '').length != string_array.length }
      raise ImproperFormatError, "string array is improperly formatted"
    end

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
