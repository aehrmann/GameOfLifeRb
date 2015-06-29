require 'grid'
require 'grid_factory'

describe GridFactory do
  describe "creating a grid" do
    it "adds locations surrounding the initial state" do
      glider = GridFactory.from_string_array(["_@_",
                                              "__@",
                                              "@@@"])

      expected_coordinates = [[-1, -1], [-1, 0], [-1, 1], [-1, 2], [-1, 3],
                              [0, -1], [0, 0], [0, 1], [0, 2], [0, 3],
                              [1, -1], [1, 0], [1, 1], [1, 2], [1, 3],
                              [2, -1], [2, 0], [2, 1], [2, 2], [2, 3],
                              [3, -1], [3, 0], [3, 1], [3, 2], [3, 3]]
      expect(glider.locations.keys).to match_array(expected_coordinates)
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
