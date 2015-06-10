require 'cell'

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

  describe "generating neighbors index pairs within the bounds of the board" do
    let(:placeholder_width) { 10 }

    context "when the cell is touching an edge" do
      it "generates all legal index pairs for a cell in the left most column" do
        cell = Cell.new(4, 0)
        expected_index_pairs = [[3, 0],[3, 1],[4, 1],[5, 0],[5, 1]]

        expect(cell.neighbor_index_pairs(placeholder_width)).to eq(expected_index_pairs)
      end

      it "generates all legal index pairs for a cell in the right most column" do
        cell = Cell.new(3, 4)
        expected_index_pairs = [[2, 3],[2, 4],[3, 3],[4, 3],[4, 4]]

        expect(cell.neighbor_index_pairs(5)).to eq(expected_index_pairs)
      end
    end

    context "when the cell is not touching any edges" do
      it "generates generates index pairs for all 8 neighbors" do
        cell = Cell.new(3, 5)
        expected_index_pairs = [[2, 4],[2, 5],[2, 6],[3, 4],[3, 6],[4, 4],[4, 5],[4, 6]]
        expect(cell.neighbor_index_pairs(placeholder_width)).to eq(expected_index_pairs)
      end
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
