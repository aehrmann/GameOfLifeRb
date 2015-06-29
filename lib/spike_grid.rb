class SpikeGrid
  Cell = Struct.new(:row, :column, :alive) do
    def to_s
      "[#{self.row}, #{self.column}: #{self.alive ? 'alive' : 'dead'}]"
    end
  end

  NEIGHBOR_OFFSETS = [[-1, -1],[-1, 0],[-1, 1],
                      [0, -1],[0, 1],
                      [1, -1],[1, 0],[1, 1]]

  attr_accessor :locations

  def initialize(locations)
    @locations = locations
  end

  def self.from_state(state)
    locations = {}
    state.each.with_index do |arr, row_index|
      arr.each_char.with_index do |char, col_index|
        cell = Cell.new(row_index, col_index, char == '@')
        locations[[row_index, col_index]] = cell
      end
    end
    grid = SpikeGrid.new(locations)
    grid.pad_grid
    grid
  end

  def pad_grid
    max_row = locations.keys.max_by { |r, c| r }[0]

    ((min_col - 1)..(max_col + 1)).each { |c| locations[[min_row - 1, c]] = Cell.new(min_row - 1, c, false) }
    ((min_col - 1)..(max_col + 1)).each { |c| locations[[max_row + 1, c]] = Cell.new(max_row + 1, c, false) }
    ((min_row - 1)..(max_row + 1)).each { |r| locations[[r, min_col - 1]] = Cell.new(r, min_col - 1, false)}
    ((min_row - 1)..(max_row + 1)).each { |r| locations[[r, max_col + 1]] = Cell.new(r, max_col + 1, false)}
  end

  def min_row
    locations.keys.min_by { |r, c| r }[0]
  end

  def max_row
    locations.keys.max_by { |r, c| r }[0]
  end

  def min_col
    locations.keys.min_by { |r, c| c }[1]
  end

  def max_col
    locations.keys.max_by { |r, c| c }[1]
  end

  def tick
    new_locations = locations.clone

    cells_to_update.each do |cell|
      if cell.alive
        cell.alive = false
      else
        cell.alive = true
      end
      all_neighbor_locations(cell.row, cell.column).each do |(r, c)|
        if !new_locations.has_key?([r, c])
          new_locations[[r, c]] = Cell.new(r, c, false)
        end
      end
    end

    remove_irrelevant_locations

    SpikeGrid.new(new_locations)
  end

  def remove_irrelevant_locations
    locations.each_key do |(row, col)|
      if count_living_neighbors(row, col) == 0
        locations.delete([row, col])
      end
    end
  end

  def cells_to_update
    results = []
    locations.each_value do |cell|
      if cell.alive
        results.push(cell) if overpopulated?(cell) || underpopulated?(cell)
      else
        results.push(cell) if can_reproduce?(cell)
      end
    end
    results
  end

  def count_living_neighbors(row, col)
    all_neighbor_locations(row, col).select { |(r, c)| locations[[r, c]].alive == true if locations.has_key?([r, c])}.count
  end

  def overpopulated?(cell)
    count_living_neighbors(cell.row, cell.column) > 3
  end

  def underpopulated?(cell)
    count_living_neighbors(cell.row, cell.column) < 2
  end

  def can_reproduce?(cell)
    count_living_neighbors(cell.row, cell.column) == 3
  end

  def all_neighbor_locations(row, col)
    NEIGHBOR_OFFSETS.map { |offset_pair| [row + offset_pair[0], col + offset_pair[1]] }
  end

  def living_cell_count
    living = 0
    locations.values.each do |cell|
      living += 1 if cell.alive
    end
    living
  end

  def empty?
    living_cell_count == 0
  end
end
