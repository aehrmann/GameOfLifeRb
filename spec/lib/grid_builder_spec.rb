require 'grid_builder'

describe GridBuilder do
  describe "creating a new grid" do
    before(:each) do
      @test_grid = GridBuilder.from_initial_state([
        "_@_",
        "__@",
        "@@@"
      ])
    end

    context "when passed an initial state configuration" do
      it "stores all of the live cells specified in the initial state" do
        expect(@test_grid.number_of_living_cells).to eq(5)
      end

      it "adds a border of dead cells around the given grid" do
        padded_locations = [
          Location.new(-1, -1),
          Location.new(-1, 0),
          Location.new(-1, 1),
          Location.new(-1, 2),
          Location.new(-1, 3),
          Location.new(0, -1),
          Location.new(0, 3),
          Location.new(1, -1),
          Location.new(1, 3),
          Location.new(2, -1),
          Location.new(2, 3),
          Location.new(3, -1),
          Location.new(3, 0),
          Location.new(3, 1),
          Location.new(3, 2),
          Location.new(3, 3),
        ]

        padded_locations.each do |location|
          expect(@test_grid.cell_exists_at?(location)).to be true
        end
      end
    end
  end
end
