require 'grid'

describe Grid do
  def empty_grid
    GridBuilder.empty_grid
  end

  let(:a_location) { Location.new(1, 1) }

  before(:each) do
    @fresh_grid = empty_grid
  end

  describe "the attributes of a grid" do
    it "stores the width and height of the original state" do
      grid = GridBuilder.from_initial_state(["__", "__", "__"])
      expect(grid.width).to eq(2)
      expect(grid.height).to eq(3)
    end
  end

  describe "#add_live_cell_at" do
    it "creates a living cell at a given location" do
      @fresh_grid.add_live_cell_at(a_location)
      expect(@fresh_grid.live_cell_at?(a_location)).to be true
    end
  end

  describe "checking the status of a cell at a location" do

    describe "#live_cell_at?" do
      context "when there is a live cell at a location" do
        it "returns true" do
          @fresh_grid.add_live_cell_at(a_location)
          expect(@fresh_grid.live_cell_at?(a_location)).to be true
        end
      end

      context "when there is no cell at a location" do
        it "returns false" do
          expect(@fresh_grid.live_cell_at?(a_location)).to be false
        end
      end

      context "when there is a dead cell at a location" do
        it "returns false" do
          @fresh_grid.add_live_cell_at(a_location)
          @fresh_grid.add_dead_cell_at(a_location)
          expect(@fresh_grid.live_cell_at?(a_location)).to be false
        end
      end
    end

    describe "#cell_exists_at?" do
      context "when there is no cell at a location" do
        it "returns false" do
          expect(@fresh_grid.cell_exists_at?(a_location)).to be false
        end
      end

      context "when there is a cell at a location" do
        it "returns true if the cell is dead" do
          @fresh_grid.add_live_cell_at(a_location)
          @fresh_grid.add_dead_cell_at(a_location)
          expect(@fresh_grid.cell_exists_at?(a_location)).to be true
        end

        it "returns true if the cell is alive" do
          @fresh_grid.add_live_cell_at(a_location)
          expect(@fresh_grid.cell_exists_at?(a_location)).to be true
        end
      end
    end
  end

  describe "#number_of_living_neighbors" do

    context "when the location has no neighboring locations with living cells" do
      it "returns 0" do
        grid = empty_grid
        expect(grid.number_of_living_neighbors(a_location)).to eq(0)
      end
    end

    context "when at least one of the neighboring locations has a living cell" do
      it "returns the number of locations with living neighbors" do
        grid = empty_grid
        location = Location.new(1, 1)
        grid.add_live_cell_at(Location.new(1, 2))

        expect(grid.number_of_living_neighbors(location)).to eq(1)
      end
    end
  end

  describe "#empty?" do

    context "when there are no living cells" do
      it "returns true immediately after creation" do
        expect(@fresh_grid.empty?).to be true
      end

      it "returns true when all existent cells are dead" do
        @fresh_grid.add_live_cell_at(a_location)
        @fresh_grid.add_dead_cell_at(a_location)
        expect(@fresh_grid.empty?).to be true
      end
    end

    context "when there is at least one living cell" do
      it "returns false" do
        @fresh_grid.add_live_cell_at(a_location)
        expect(@fresh_grid.empty?).to be false
      end
    end
  end

  describe "#locations_to_update" do
    let(:test_grid) do
      GridBuilder.from_initial_state([
        "@_@__",
        "__@__",
        "_@@@@",
        "@__@@"
      ])
    end
    context "when the cell at the location is alive" do
      context "and the cell at the location has fewer than two living neighbors" do
        it "should be updated" do
          expect(test_grid.locations_to_update).to include(Location.new(0, 0))
          expect(test_grid.locations_to_update).to include(Location.new(0, 2))
        end
      end

      context "and the cell at the location has either two or three living neighbors" do
        it "should not be updated" do
          expect(test_grid.locations_to_update).not_to include(Location.new(0, 3))
          expect(test_grid.locations_to_update).not_to include(Location.new(3, 5))
        end
      end

      context "and the cell at the location has more than three neighbors" do
        it "should be updated" do
          expect(test_grid.locations_to_update).to include(Location.new(3, 3))
        end
      end
    end

    context "when the cell at the location is dead" do
      context "and the cell at the location has exactly three living neighbors" do
        it "should be updated" do
          expect(test_grid.locations_to_update).to include(Location.new(3, 1))
        end
      end
    end
  end
  
  describe "#tick" do
    it "should update the cells at the relevant locations" do
      glider_grid = GridBuilder.from_initial_state([
        "_@_",
        "__@",
        "@@@"
      ])

      next_grid = glider_grid.tick

      expected_living_locations = [
        Location.new(1, 0),
        Location.new(1, 2),
        Location.new(2, 1),
        Location.new(2, 2),
        Location.new(3, 1)
      ]

      expected_living_locations.each do |location|
        expect(next_grid.live_cell_at?(location)).to be true
      end
    end
  end

  describe "#==" do
    it "return true if the grid has the same locations and cells" do
      intitial_state = ["@_"]
      grid = GridBuilder.from_initial_state(intitial_state)
      equivalent_grid = GridBuilder.from_initial_state(intitial_state)
      expect(grid).to eq(equivalent_grid)
    end

    it "return false otherwise" do
      grid = GridBuilder.from_initial_state(["@"])
      different_grid = GridBuilder.from_initial_state(["_"])
      expect(grid).not_to eq(different_grid)
    end
  end
end
