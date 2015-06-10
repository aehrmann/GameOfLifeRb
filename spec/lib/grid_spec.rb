require 'grid'
require 'grid_factory'

describe Grid do

  describe "checking a cell's living status" do
    before(:each) { @grid = GridFactory.empty_grid(10) }

    it "returns false if there is no cell at the given coordinates" do
      expect(@grid.living_cell?(2, 8)).to be false
    end

    it "returns true if there a cell at the given position" do
      @grid.spawn_cell_at(5, 2)
      expect(@grid.living_cell?(5, 2)).to be true
    end

    it "returns false if the coordinates are outside of the grid's bounds" do
      expect(@grid.living_cell?(0, 20)).to be false
      expect(@grid.living_cell?(20, 0)).to be false
      expect(@grid.living_cell?(-10, 0)).to be false
    end

    describe "retrieving the number of living neighbors for a cell" do
      before(:each) { @grid = GridFactory.empty_grid(10) }

      it "returns 0 for a cell with no living neighbors" do
        expect(@grid.count_living_neighbors(1, 9)).to eq(0)
      end

      it "returns the number of living neighbors in the row above the given cell" do
        @grid.spawn_cell_at(3, 3)
        @grid.spawn_cell_at(3, 4)
        @grid.spawn_cell_at(3, 5)
        expect(@grid.count_living_neighbors(4, 4)).to eq(3)
      end

      it "returns the number of living neighbors in the same row as the given cell" do
        @grid.spawn_cell_at(1, 4)
        @grid.spawn_cell_at(1, 6)
        expect(@grid.count_living_neighbors(1, 5)).to eq(2)
      end

      it "returns the number of living neighbors in the row below the given cell" do
        @grid.spawn_cell_at(8, 7)
        @grid.spawn_cell_at(8, 8)
        @grid.spawn_cell_at(8, 9)
        expect(@grid.count_living_neighbors(7, 8)).to eq(3)
      end
    end

    describe "finding cells that will be updated on the next tick" do
      it "returns no cell coordinates for an empty grid" do
        grid = GridFactory.empty_grid(10)
        expect(grid.cells_to_update).to eq([])
      end

      it "returns live cells with fewer than 2 living neighbors" do
        grid = GridFactory.empty_grid(10)
        grid.spawn_cell_at(1, 2)
        grid.spawn_cell_at(4, 7)
        grid.spawn_cell_at(3, 7)

        expect(grid.cells_to_update).to include([1, 2])
        expect(grid.cells_to_update).to include([4, 7])
      end

      it "returns live cells with more than 3 living neighbors" do
        grid = GridFactory.empty_grid(10)
        grid.spawn_cell_at(1, 3)

        grid.spawn_cell_at(2, 2)
        grid.spawn_cell_at(2, 3)
        grid.spawn_cell_at(1, 2)
        grid.spawn_cell_at(0, 2)

        expect(grid.cells_to_update).to include([1, 3])
      end

      it "returns dead cells with exactly 3 living neighbors" do
        grid = GridFactory.empty_grid(10)
        grid.spawn_cell_at(0, 1)
        grid.spawn_cell_at(1, 0)
        grid.spawn_cell_at(1, 1)

        expect(grid.cells_to_update).to include([0, 0])
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
end
