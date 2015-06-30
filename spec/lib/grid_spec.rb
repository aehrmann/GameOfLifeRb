require 'grid'

describe Grid do

  describe "#spawn_cell_at" do
    before(:each) do
      @new_grid = Grid.new
    end

    it "creates a living cell at a given location" do
      location = Location.new(0, 0)
      @new_grid.spawn_cell_at(location)
      expect(@new_grid.live_cell_at?(location)).to be true
    end
  end

  describe "checking the status of a cell at a location" do
    let(:test_location) { Location.new(1, 1) }

    before(:each) do
      @new_grid = Grid.new
    end

    describe "#live_cell_at?" do
      context "when there is a live cell at a location" do
        it "returns true" do
          @new_grid.spawn_cell_at(test_location)
          expect(@new_grid.live_cell_at?(test_location)).to be true
        end
      end

      context "when there is no cell at a location" do
        it "returns false" do
          expect(@new_grid.live_cell_at?(test_location)).to be false
        end
      end

      context "when there is a dead cell at a location" do
        it "returns false" do
          @new_grid.spawn_cell_at(test_location)
          @new_grid.kill_cell_at(test_location)
          expect(@new_grid.live_cell_at?(test_location)).to be false
        end
      end
    end

    describe "#cell_exists_at?" do
      let(:test_location) { Location.new(0, 0) }
      before(:each) do
        @new_grid = Grid.new
      end

      context "when there is no cell at a location" do
        it "returns false" do
          expect(@new_grid.cell_exists_at?(test_location)).to be false
        end
      end

      context "when there is a cell at a location" do
        it "returns true if the cell is dead" do
          @new_grid.spawn_cell_at(test_location)
          @new_grid.kill_cell_at(test_location)
          expect(@new_grid.cell_exists_at?(test_location)).to be true
        end

        it "returns true if the cell is alive" do
          @new_grid.spawn_cell_at(test_location)
          expect(@new_grid.cell_exists_at?(test_location)).to be true
        end
      end
    end
  end

  describe "#number_of_living_neighbors" do
    let(:test_location) { Location.new(0, 0) }

    context "when the location has no neighboring locations with living cells" do
      it "returns 0" do
        grid = Grid.new
        expect(grid.number_of_living_neighbors(test_location)).to eq(0)
      end
    end

    context "when at least one of the neighboring locations has a living cell" do
      it "returns the number of locations with living neighbors" do
        grid = Grid.new
        location = Location.new(1, 1)
        grid.spawn_cell_at(Location.new(1, 2))

        expect(grid.number_of_living_neighbors(location)).to eq(1)
      end
    end
  end

  describe "#empty?" do
    let(:test_location) { Location.new(1, 1) }
    before(:each) do
      @new_grid = Grid.new
    end

    context "when there are no living cells" do
      it "returns true immediately after creation" do
        expect(Grid.new.empty?).to be true
      end

      it "returns true when all existent cells are dead" do
        @new_grid.spawn_cell_at(test_location)
        @new_grid.kill_cell_at(test_location)
        expect(@new_grid.empty?).to be true
      end
    end

    context "when there is at least one living cell" do
      it "returns false" do
        @new_grid.spawn_cell_at(test_location)
        expect(@new_grid.empty?).to be false
      end
    end
  end
end
