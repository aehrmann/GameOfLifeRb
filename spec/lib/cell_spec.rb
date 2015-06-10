require 'cell'

describe Cell do
  describe "creating a cell" do
    it "requires a row and a column" do
      cell = Cell.new(3, 5)
      expect(cell.row).to eq(3)
      expect(cell.col).to eq(5)
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
end
