require 'cell'

describe Cell do
  describe "creating a cell" do
    it "requires a row and a column" do
      cell = Cell.new(3, 5)
      expect(cell.row).to eq(3)
      expect(cell.col).to eq(5)
    end
  end
end
