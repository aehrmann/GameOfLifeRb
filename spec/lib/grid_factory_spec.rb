require 'grid'
require 'grid_factory'

describe GridFactory do
  describe "creating a grid" do
    it "adds locations surrounding the initial state" do
      grid = GridFactory.from_string_array(["_@",
                                            "@@"])
      expected_locations = [[-1, -1], [-1, 0], [-1, 1], [-1, 2],
                            [0, -1], [0, 0], [0, 1], [0, 2],
                            [1, -1], [1, 0], [1, 1], [1, 2],
                            [2, -1], [2, 0], [2, 1], [2, 2]]
      expected_locations.each do |(row, col)|
        expect(grid.cell_at(row, col)).not_to be_nil
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
