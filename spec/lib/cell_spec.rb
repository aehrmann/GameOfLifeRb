require 'cell'

describe Cell do
  describe "creating a cell" do
    it "requires a row and a column" do
      cell = Cell.new(3, 5)
      expect(cell.row).to eq(3)
      expect(cell.col).to eq(5)
    end
  end

  describe "generating neighbors index pairs" do
    context "when the cell is touching an edge" do
      it "generates all legal index pairs" do
        cell = Cell.new(4, 0)
        expected_index_pairs = [[1, 0],[0, 1],[]]
      end
    end
    it "generates generates index pairs for all 8 neighbors" do
      cell = Cell.new(3, 5)
    end
  end
end
