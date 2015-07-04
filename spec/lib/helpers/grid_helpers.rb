module GridHelpers

  def self.empty_grid
    GridBuilder.empty_grid
  end

  def self.locations_for_ranges(row_range, column_range)
    locations = []
    row_range.each do |row|
      column_range.each do |column|
        locations << Location.new(row, column)
      end
    end
    locations
  end

  def self.locations_for_pairs(pairs)
    locations = []
    pairs.each do |(row, column)|
      locations << Location.new(row, column)
    end
    locations
  end
end
