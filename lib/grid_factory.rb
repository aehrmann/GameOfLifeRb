require_relative 'cell'
require_relative 'grid'

module GridFactory

  class ImproperFormatError < StandardError; end

  def self.from_parsed_input(contents)
    string_array = contents.split("\n").map { |line| line.strip }
    self.from_string_array(string_array)
  end

  def self.from_string_array(string_array)
    locations = {}
    string_array.each.with_index do |string, row|
      string.each_char.each.with_index do |char, col|
        locations[[row, col]] = Cell.new(row, col, char == '@')
      end
    end
    Grid.new(locations)
  end

  def self.empty_grid(dimension)
    row_string = '_' * dimension
    string_array = [row_string] * dimension
    self.from_string_array(string_array)
  end
end
