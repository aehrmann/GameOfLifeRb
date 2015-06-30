require 'grid'

describe Grid do
  def empty_grid
    Grid.new
  end

  let(:a_location) { Location.new(1, 1) }

  before(:each) do
    @fresh_grid = empty_grid
  end

  describe "#spawn_cell_at" do
    it "creates a living cell at a given location" do
      @fresh_grid.spawn_cell_at(a_location)
      expect(@fresh_grid.live_cell_at?(a_location)).to be true
    end
  end

  describe "checking the status of a cell at a location" do

    describe "#live_cell_at?" do
      context "when there is a live cell at a location" do
        it "returns true" do
          @fresh_grid.spawn_cell_at(a_location)
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
          @fresh_grid.spawn_cell_at(a_location)
          @fresh_grid.kill_cell_at(a_location)
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
          @fresh_grid.spawn_cell_at(a_location)
          @fresh_grid.kill_cell_at(a_location)
          expect(@fresh_grid.cell_exists_at?(a_location)).to be true
        end

        it "returns true if the cell is alive" do
          @fresh_grid.spawn_cell_at(a_location)
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
        grid.spawn_cell_at(Location.new(1, 2))

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
        @fresh_grid.spawn_cell_at(a_location)
        @fresh_grid.kill_cell_at(a_location)
        expect(@fresh_grid.empty?).to be true
      end
    end

    context "when there is at least one living cell" do
      it "returns false" do
        @fresh_grid.spawn_cell_at(a_location)
        expect(@fresh_grid.empty?).to be false
      end
    end
  end
end
