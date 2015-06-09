require 'grid'
require 'grid_parser'

describe GridParser do
  describe "creating a grid" do

    describe ".empty_grid" do
      let(:grid) { GridParser.empty_grid(5) }

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
        grid = GridParser.from_string_array(['___',
                                             '@@@',
                                             '_@_'])

        expected_cells = [[false, false, false],
                          [true, true, true],
                          [false, true, false]]

        expect(grid.cells).to eq(expected_cells)
      end

      it "raises an error if the string array is not properly formatted" do
        expect{ GridParser.from_string_array(['_',
                                              '___',
                                              '_@_']) }.to raise_error
      end
    end
  end
end
