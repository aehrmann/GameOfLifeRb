module GridFactory

  class ImproperFormatError < StandardError; end

  def self.from_string_array(string_array)
    if string_array.any? { |str| str.gsub(/,/, '').length != string_array.length }
      raise ImproperFormatError, "string array is improperly formatted"
    end

    new_cells = string_array.map do |string|
      string.each_char.map { |char| char == '@' }
    end

    Grid.new(string_array.length, new_cells)
  end

  def self.empty_grid(dimension)
    cells = Array.new(dimension) { Array.new(dimension, false) }
    Grid.new(dimension, cells)
  end
end
