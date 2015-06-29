class Location
  attr_reader :row, :column
  def initialize(row, column)
    @row, @column = row, column
  end

  def ==(other)
    self.row == other.row && self.column == other.column
  end

  alias eql? ==
  
  def hash
    self.row ^ self.column
  end
end
