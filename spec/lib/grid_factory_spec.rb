require 'grid'
require 'grid_factory'

describe GridFactory do
  describe "creating a grid" do

    describe ".empty_grid" do
      let(:grid) { GridFactory.empty_grid(5) }

      it "creates a grid of cells with the given dimension" do
        expect(grid.dimension).to eq(5)
      end

      it "sets all cells to dead" do
        all_dead = grid.cells.all? do |row|
          row.all? { |cell| !cell.alive? }
        end
        expect(all_dead).to be true
      end
    end

    describe ".from_string_array" do
      it "creates a grid from an array of strings" do
        grid = GridFactory.from_string_array(['___',
                                             '@@@',
                                             '_@_'])

        expected_cells = [[Cell.new(0, 0), Cell.new(0, 1), Cell.new(0, 2)],
                          [Cell.new(1, 0, true), Cell.new(1, 1, true), Cell.new(1, 2, true)],
                          [Cell.new(2, 0), Cell.new(2, 1, true), Cell.new(2, 2)]]

        expect(grid.cells).to eq(expected_cells)
      end

      it "raises an error if the string array is not properly formatted" do
        expect{ GridFactory.from_string_array(['_',
                                              '___',
                                              '_@_']) }.to raise_error
      end
    end

    describe ".from_parsed_input" do
      it "parses the string contents of a file" do
        contents = <<-eos
          ____
          __@_
          _@__
          _@__
        eos
        expected_grid = GridFactory.from_string_array(['____',
                                                       '__@_',
                                                       '_@__',
                                                       '_@__'])
        expect(GridFactory.from_parsed_input(contents)).to eq(expected_grid)
      end
    end
  end
end
