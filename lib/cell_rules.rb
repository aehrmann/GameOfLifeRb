class CellRules
  attr_reader :grid
  def initialize(grid)
    @grid = grid
  end

  def should_change_status?(location)
    if grid.alive_at?(location)
      cell_dies_in_next_generation?(location)
    else
      cell_comes_to_life_in_next_generation?(location)
    end
  end

  private
  def underpopulated?(location)
    grid.number_of_living_neighbors(location) < 2
  end

  def overpopulated?(location)
    grid.number_of_living_neighbors(location) > 3
  end

  def stable_population?(location)
    grid.number_of_living_neighbors(location) == 3
  end

  def cell_dies_in_next_generation?(location)
    underpopulated?(location) || overpopulated?(location)
  end

  def cell_comes_to_life_in_next_generation?(location)
    stable_population?(location)
  end
end
