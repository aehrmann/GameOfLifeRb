require 'cell'
require 'grid'
require 'grid_factory'

describe Cell do
  describe "creating a cell" do
    before(:each) { @cell = Cell.new(3, 5) }

    it "requires a row and a column" do
      expect(@cell.row).to eq(3)
      expect(@cell.col).to eq(5)
    end

    it "starts out dead by default" do
      expect(@cell.alive?).to be false
    end

    it "can be set to living on creation" do
      cell = Cell.new(3, 5, true)
      expect(cell.alive?).to be true
    end
  end

  describe "changing mortal status" do
    before(:each) { @cell = Cell.new(3, 3) }

    it "can come back to life" do
      @cell.live!

      expect(@cell.alive?).to be true
    end

    it "can die" do
      @cell.live!
      @cell.die!

      expect(@cell.alive?).to be false
    end
  end

  describe "generating neighbors index pairs" do
    before(:each) { @grid = GridFactory.empty_grid(5) }

    context "when the cell is touching an edge" do
      it "generates all legal index pairs for a cell in the left most column" do
        cell = Cell.new(3, 0)
        expected_index_pairs = [[2, 0],[2, 1],[3, 1],[4, 0],[4, 1]]

        expect(cell.neighbor_index_pairs(@grid)).to eq(expected_index_pairs)
      end

      it "generates all legal index pairs for a cell in the right most column" do
        cell = Cell.new(3, 4)
        expected_index_pairs = [[2, 3],[2, 4],[3, 3],[4, 3],[4, 4]]

        expect(cell.neighbor_index_pairs(@grid)).to eq(expected_index_pairs)
      end
    end

    context "when the cell is not touching any edges" do
      it "generates generates index pairs for all 8 neighbors" do
        cell = Cell.new(3, 2)
        expected_index_pairs = [[2, 1],[2, 2],[2, 3],[3, 1],[3, 3],[4, 1],[4, 2],[4, 3]]
        expect(cell.neighbor_index_pairs(@grid)).to eq(expected_index_pairs)
      end
    end
  end
  
  describe "counting a cell's living neighbors" do
    it "returns the number of living neighboring cells" do
      grid = GridFactory.from_string_array(["_@@",
                                            "_@_",
                                            "@@@"])
      cell = Cell.new(1, 1)

      expect(cell.number_of_living_neighbors(grid)).to eq(5)
    end
  end

  describe "comparing two cells" do
    it "compares index pairs and mortal status" do
      expect(Cell.new(2, 2, true)).to eq(Cell.new(2, 2, true))
      expect(Cell.new(2, 2)).not_to eq(Cell.new(2, 2, true))
      expect(Cell.new(3, 3, false)).not_to eq(Cell.new(3, 3, true))
    end
  end

end
