require 'grid'
require 'cell_rules'
require 'grid_formatter'

module GridSpecHelpers

  def self.empty_grid
    GridBuilder.empty_grid
  end

  def self.locations_for_ranges(row_range, column_range)
    locations = []
    row_range.each do |row|
      column_range.each do |column|
        locations << Location.new(row, column)
      end
    end
    locations
  end

  def self.locations_for_pairs(pairs)
    locations = []
    pairs.each do |(row, column)|
      locations << Location.new(row, column)
    end
    locations
  end
end

describe Grid do


  before(:each) do
    @fresh_grid = GridSpecHelpers::empty_grid
    @test_location = Location.new(1, 1) 
  end

  describe "the attributes of a grid" do
    let(:two_by_three_grid) { GridBuilder.from_initial_state(["__",
                                                              "__",
                                                              "__"]) }
    it "stores the width and height of the original state" do
      expect(two_by_three_grid.width).to eq(2)
      expect(two_by_three_grid.height).to eq(3)
    end

    it "contains cell rules" do
      expect(two_by_three_grid.rules).not_to be_nil
    end
  end

  describe "#set_living_at" do
    it "creates a living cell at a given location" do
      @fresh_grid.set_living_at(@test_location)
      expect(@fresh_grid.alive_at?(@test_location)).to be true
    end
  end

  describe "checking the status of a cell at a location" do

    describe "#alive_at?" do

      context "when there is a live cell at a location" do
        it "returns true" do
          @fresh_grid.set_living_at(@test_location)
          expect(@fresh_grid.alive_at?(@test_location)).to be true
        end
      end

      context "when there is a dead cell at a location" do
        it "returns false" do
          @fresh_grid.set_living_at(@test_location)
          @fresh_grid.set_dead_at(@test_location)
          expect(@fresh_grid.alive_at?(@test_location)).to be false
        end
      end

      context "when there is no cell at a location" do
        it "returns false" do
          expect(@fresh_grid.alive_at?(@test_location)).to be false
        end
      end
    end

    describe "#exists_at?" do

      context "when there is no cell at a location" do
        it "returns false" do
          expect(@fresh_grid.exists_at?(@test_location)).to be false
        end
      end

      context "when there is a cell at a location" do
        it "returns true if the cell is alive" do
          @fresh_grid.set_living_at(@test_location)
          expect(@fresh_grid.alive_at?(@test_location)).to be true
        end

        it "returns true if the cell is dead" do
          @fresh_grid.set_dead_at(@test_location)
          expect(@fresh_grid.exists_at?(@test_location)).to be true
        end
      end
    end
  end

  describe "#number_of_living_neighbors" do

    context "when there are no living cells" do
      it "returns 0" do
        expect(GridSpecHelpers::empty_grid.number_of_living_neighbors(@test_location)).to eq(0)
      end
    end

    context "when at least one of the neighboring locations has a living cell" do
      it "returns the number of locations with living neighbors" do
        grid = GridSpecHelpers::empty_grid
        grid.set_living_at(Location.new(1, 1))

        expect(grid.number_of_living_neighbors(Location.new(1, 2))).to eq(1)
      end
    end
  end

  describe "#empty?" do

    context "when there are no living cells" do
      it "returns true immediately after creation" do
        expect(@fresh_grid.empty?).to be true
      end

      it "returns true when all existing cells are dead" do
        @fresh_grid.set_living_at(@test_location)
        @fresh_grid.set_dead_at(@test_location)
        expect(@fresh_grid.empty?).to be true
      end
    end

    context "when there is at least one living cell" do
      it "returns false" do
        @fresh_grid.set_living_at(@test_location)
        expect(@fresh_grid.empty?).to be false
      end
    end
  end

  describe "#locations" do

    it "returns the set of locations for all cells on the grid" do  
      grid = GridBuilder.from_initial_state(["_@", 
                                             "@@"])

      expected_locations = GridSpecHelpers::locations_for_ranges((-1..2), (-1..2))

      expect(grid.locations).to match_array(expected_locations)
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

    context "when a cell is living" do
      context "and the cell has fewer than two living neighbors" do
        it "should be updated" do
          expect(test_grid.locations_to_update).to include(*GridSpecHelpers::locations_for_pairs([[0, 0], [0, 2]]))
        end
      end

      context "and the cell has either two or three living neighbors" do
        it "should not be updated" do
          expect(test_grid.locations_to_update).not_to include(*GridSpecHelpers::locations_for_pairs([[0, 3], [3, 5]]))
        end
      end

      context "and the cell has more than three neighbors" do
        it "should be updated" do
        expect(test_grid.locations_to_update).to include(*GridSpecHelpers::locations_for_pairs([[2, 2], [3, 3]]))
        end
      end
    end

    context "when the cell at the location is dead" do
      context "and the cell has exactly three living neighbors" do
        it "should be updated" do
          expect(test_grid.locations_to_update).to include(Location.new(3, 1))
        end
      end
    end
  end

  describe "#next_generation" do

    fit "generates the next generation of cells" do
      glider_grid = GridBuilder.from_initial_state([
        "_@_",
        "__@",
        "@@@"
      ])

      next_grid = glider_grid.next_generation

      expected_living_locations = next_grid.locations.select { |location| next_grid.alive_at?(location) }

      expected_living_locations.each do |location|
        expect(next_grid.alive_at?(location)).to be true
      end
    end

    it "removes the irrelevant cells from the grid" do
      grid = GridBuilder.from_initial_state([
        "__",
        "@@"
      ])
      next_grid = grid.next_generation

      expect(next_grid.cells.empty?).to be true
    end
  end

  describe "#add_all_neighbor_locations_of" do

    it "adds dead cells to vacant neighbors of a location" do
      grid = GridBuilder.from_initial_state([
        "@_@",
        "_@@",
        "@@@"
      ])

      grid.add_all_neighbor_locations_of(Location.new(1, 1))
      expected_added_locations = [
        Location.new(0, 1),
        Location.new(1, 0)
      ]

      expected_added_locations.each do |location|
        expect(grid.exists_at?(location)).to be true
      end
    end
  end

  describe "#==" do
    it "returns true if the grid has the same set of cells at each location" do
      the_intitial_state = ["@_"]

      grid = GridBuilder.from_initial_state(the_intitial_state)
      equivalent_grid = GridBuilder.from_initial_state(the_intitial_state)

      expect(grid).to eq(equivalent_grid)
    end

    it "return false otherwise" do
      grid = GridBuilder.from_initial_state(["@"])
      different_grid = GridBuilder.from_initial_state(["_"])

      expect(grid).not_to eq(different_grid)
    end
  end
end
