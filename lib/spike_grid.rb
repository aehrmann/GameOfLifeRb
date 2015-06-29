class SpikeGrid
  Cell = Struct.new(:row, :column, :alive) do
    def to_s
      "[(#{self.row}, #{self.column}: #{self.alive ? 'alive' : 'dead'}]"
    end
  end

  attr_accessor :locations
  def initialize(state)
    @locations = {}
    state.each.with_index.each do |arr, row_index|
      arr.each.with_index.each do |char, col_index|
        cell = Cell.new(row_index, col_index)
        locations[[row_index, col_index]] = cell
        char == '@' ? cell.live! : cell.die!
      end
    end
  end

  #def new_cell(row, col, alive)
    #Cell.new(row, col, alive)
  #end

  #def spawn_cell_at(row, col)
    #locations[[row, col]] = Cell.new(row, col, true)
  #end

end


grid = SpikeGrid.new([%w{ _ @ _ },
                      %w{ _ _ @ },
                      %w{ @ @ @ }])
grid.spawn_cell_at(50, 50)
grid.locations.each_pair do |(row, col), cell|
  puts "[#{cell.row}, #{cell.column}] => #{cell.to_s}"
end
