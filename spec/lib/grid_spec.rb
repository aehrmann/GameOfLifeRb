require 'grid'

describe Grid do
  describe "creating a grid" do
    describe "#new" do
      let(:grid) { Grid.new(5) }
      it "creates a grid of cells with the given dimension" do
        expect(grid.dimension).to eq(5)
      end

      it "sets all cells to dead" do
        all_dead = grid.cells.all? do |row|
          row.all? { |cell| cell == false }
        end
        expect(all_dead).to be true
      end
    end

    describe ".from_string_array" do
      it "creates a grid from an array of strings" do
        grid = Grid.from_string_array(['___',
                                         '@@@',
                                         '_@_'])

        expected_cells = [[false, false, false],
                          [true, true, true],
                          [false, true, false]]

        expect(grid.cells).to eq(expected_cells)
      end

      it "raises an error if the string array is not properly formatted" do
        expect{ grid.from_string_array(['_','___','_@_']) }.to raise_error
      end
    end
  end

  describe "checking a cell's living status" do
    before(:each) { @grid = Grid.new(10) }

    it "returns false if there is no cell at the given coordinates" do
      expect(@grid.living_cell?(2, 8)).to be false
    end

    it "returns true if there a cell at the given position" do
      @grid.spawn_cell_at(5, 2)
      expect(@grid.living_cell?(5, 2)).to be true
    end

    it "returns false if the coordinates are not within the grid's bounds" do
      expect(@grid.living_cell?(0, 20)).to be false
      expect(@grid.living_cell?(20, 0)).to be false
      expect(@grid.living_cell?(-10, 0)).to be false
    end
  end

  describe "retrieving the number of living neighbors for a cell" do
    before(:each) { @grid = Grid.new(10) }

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

  describe "finding cells to change" do
    it "returns no cell coordinates for an empty grid" do
      grid = Grid.new(10)
      expect(grid.cells_to_update).to eq([])
    end

    it "returns live cells with fewer than 2 living neighbors" do
      grid = Grid.new(10)
      grid.spawn_cell_at(1, 2)
      grid.spawn_cell_at(4, 7)
      grid.spawn_cell_at(3, 7)

      expect(grid.cells_to_update).to include([1, 2])
      expect(grid.cells_to_update).to include([4, 7])
    end

    it "returns live cells with more than 3 living neighbors" do
      grid = Grid.new(10)
      grid.spawn_cell_at(1, 3)

      grid.spawn_cell_at(2, 2)
      grid.spawn_cell_at(2, 3)
      grid.spawn_cell_at(1, 2)
      grid.spawn_cell_at(0, 2)

      expect(grid.cells_to_update).to include([1, 3])
    end

    it "returns dead cells with exactly 3 living neighbors" do
      grid = Grid.new(10)
      grid.spawn_cell_at(0, 1)
      grid.spawn_cell_at(1, 0)
      grid.spawn_cell_at(1, 1)

      expect(grid.cells_to_update).to include([0, 0])
    end
  end

  describe "one tick" do
    it "returns an updated version of the grid" do
      grid_before = Grid.from_string_array([ '@_@_',
                                               '__@_',
                                               '@@__',
                                               '@@__'])
      grid_after = Grid.from_string_array(['_@__',
                                             '@_@_',
                                             '@_@_',
                                             '@@__'])
      expect(grid_before.tick).to eq(grid_after)
    end
  end
end
