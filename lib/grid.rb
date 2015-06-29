require_relative './cell'

class Grid
  attr_accessor :locations

  def initialize(state)
    if state.is_a?(Hash)
      puts "&&&&&&&&&&&&&&&&&&&&"
      puts "tick construction"
      #@locations = {}
      #state.each_pair do |(row, col), cell|
        #if @locations.has_key?([row, col]) && @locations[[row, col]].number_of_living_neighbors(self) == 0
      #end
      @locations = state
    elsif state.is_a?(Array)
      puts "initial construction"
      @locations = {}
      state.each.with_index do |arr, row_index|
        arr.each.with_index do |char, col_index|
          if char == '@'
            @locations[[row_index, col_index]] = LivingCell.new(row_index, col_index)
          else
            @locations[[row_index, col_index]] = DeadCell.new(row_index, col_index)
          end
        end
      end
      pad_grid
      puts "with padding: #{locations.count} cells"
    end
  end

  def pad_grid
    min_row = locations.keys.min_by { |r, c| r }[0]
    max_row = locations.keys.max_by { |r, c| r }[0]

    min_col = locations.keys.min_by { |r, c| c }[1]
    max_col = locations.keys.max_by { |r, c| c }[1]

    ((min_col - 1)..(max_col + 1)).each { |c| locations[[min_row - 1, c]] = DeadCell.new(min_row - 1, c) }
    ((min_col - 1)..(max_col + 1)).each { |c| locations[[max_row + 1, c]] = DeadCell.new(max_row + 1, c) }
    ((min_row - 1)..(max_row + 1)).each { |r| locations[[r, min_col - 1]] = DeadCell.new(r, min_col - 1)}
    ((min_row - 1)..(max_row + 1)).each { |r| locations[[r, max_col + 1]] = DeadCell.new(r, max_col + 1)}
  end

  def cell_at(row, column)
    if !@locations.has_key?([row, column])
      @locations[[row, column]] = DeadCell.new(row, column)
    end
    @locations[[row, column]]
  end

  def spawn_cell_at(row, column)
    if cell_exists_at?(row, column)
      cell_at(row, column).live!
    else
      locations[[row, column]] = LivingCell.new(row, column)
      add_neighbors_of(row, column)
    end
  end

  def add_neighbors_of(row, column)
    neighbor_locations_for_cell_at(row, column).each do |(neighbor_row, neighbor_col)|
      if !cell_exists_at?(neighbor_row, neighbor_col)
        #p "adding dead cell at #{neighbor_row}, #{neighbor_col}"
        locations[[neighbor_row, neighbor_col]] = DeadCell.new(neighbor_row, neighbor_col)
      end
    end
  end

  def neighbor_locations_for_cell_at(row, column)
    @locations[[row, column]].all_neighbor_index_pairs(row, column)
  end

  def cell_exists_at?(row, column)
    locations.has_key?([row, column])
  end

  def tick
    new_locations = locations.clone

    #p new_locations
    cells_to_update.each do |cell|
      if cell.alive?
        cell.die!
      else
        cell.live!
      end
    end

    Grid.new(new_locations)
  end

  def cells_to_update
    results = []
    @locations.each_pair do |(row, col), cell|
      #puts "looking at #{row}, #{col}"
      #puts @locations[[row, col]]
      if cell.alive?
        results.push(cell) if overpopulated?(cell) || underpopulated?(cell)
      else
        results.push(cell) if can_reproduce?(cell)
      end
    end
    results
  end

  #def each_cell
    #@locations.keys.each do |(row, col)|
      #yield cell_at(row, col)
    #end
  #end

  def count_living_cells
    count = 0
    self.each_cell do |cell|
      count += 1 if cell.alive?
    end
    count
  end

  def all_cells_dead?
    self.each_cell do |cell|
      return false if cell.alive?
    end
    true
  end


  def ==(other)
    self.locations == other.locations
  end


  def overpopulated?(cell)
    cell.number_of_living_neighbors(self) > 3
  end

  def underpopulated?(cell)
    cell.number_of_living_neighbors(self) < 2
  end

  def can_reproduce?(cell)
    cell.number_of_living_neighbors(self) == 3
  end
end


grid = Grid.new([%w{ _ @ _ },
                 %w{ _ _ @ },
                 %w{ @ @ @ }])

grid.locations.each_pair do |(row, col), cell|
  puts cell
end

puts "****************************************"
next_grid = grid.tick
next_grid.locations.each_pair do |(row, col), cell|
  puts cell
end
