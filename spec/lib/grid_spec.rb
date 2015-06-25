require 'grid'
require 'grid_factory'

describe Grid do

  describe "getting a cell at a specific row and column" do
    it "returns the cell at the given row and column" do
      grid = GridFactory.from_string_array(["__",
                                            "_@"])

      expect(grid.cell_at(1, 1)).to eq(Cell.new(1, 1, true))
    end
  end

  describe "getting the number of living cells" do
    it "counts the number of living cells" do
      grid = GridFactory.from_string_array(["__",
                                            "_@"])
      expect(grid.count_living_cells).to eq(1)
      next_grid = grid.tick
      expect(next_grid.count_living_cells).to eq(0)
    end
  end

  describe "finding cells that will be updated on the next tick" do
    it "returns live cells with fewer than 2 living neighbors" do
      grid = GridFactory.from_string_array(["@_@",
                                            "__@",
                                            "___"])

      expect(grid.cells_to_update).to include(grid.cell_at(0, 0))
      expect(grid.cells_to_update).to include(grid.cell_at(0, 2))
    end

    it "returns live cells with more than 3 living neighbors" do
      grid = GridFactory.from_string_array(["__@_",
                                            "__@@",
                                            "__@@",
                                            "____"])
      expect(grid.cells_to_update).to include(grid.cell_at(1, 3))
    end

   it "returns dead cells with exactly 3 living neighbors" do
      grid = GridFactory.from_string_array(["_@",
                                            "@@"])
      expect(grid.cells_to_update).to include(grid.cell_at(0, 0))
    end
  end

  describe "reporting if all cells are dead" do
    it "returns true if there are no living cells" do
      grid = GridFactory.from_string_array(["_@",
                                            "@@"])
      expect(grid.all_cells_dead?).to be false
    end
  end

  describe "one tick" do
    it "returns an updated version of the grid" do
      grid_before = GridFactory.from_string_array([ '@_@_',
                                                    '__@_',
                                                    '@@__',
                                                    '@@__'])
      grid_after = GridFactory.from_string_array(['_@__',
                                                  '@_@_',
                                                  '@_@_',
                                                  '@@__'])
      expect(grid_before.tick).to eq(grid_after)
    end
  end
end
