require 'grid'

describe Grid do

  describe "creating a new grid" do

    context "when passed an initial state configuration" do
      it "stores all of the live cells specified in the initial state" do
        grid = Grid.new(
          ["_@",
           "@@"]
        )
        expect(grid.number_of_living_cells).to eq(3)
      end
    end
  end

  describe "#spawn_cell_at" do
    before(:each) do
      @test_grid = Grid.new
    end

    it "creates a living cell at a given location" do
      location = Location.new(0, 0)
      @test_grid.spawn_cell_at(location)
      expect(@test_grid.live_cell_at?(location)).to be true
    end
  end

  describe "checking the status of a cell at a location" do
    let(:test_location) { Location.new(1, 1) }

    before(:each) do
      @test_grid = Grid.new
    end

    describe "#live_cell_at?" do
      context "when there is a live cell at a location" do
        it "returns true" do
          @test_grid.spawn_cell_at(test_location)
          expect(@test_grid.live_cell_at?(test_location)).to be true
        end
      end

      context "when there is no cell at a location" do
        it "returns false" do
          expect(@test_grid.live_cell_at?(test_location)).to be false
        end
      end

      context "when there is a dead cell at a location" do
        it "returns false" do
          @test_grid.spawn_cell_at(test_location)
          @test_grid.kill_cell_at(test_location)
          expect(@test_grid.live_cell_at?(test_location)).to be false
        end
      end
    end

    describe "#cell_exists_at?" do
      let(:test_location) { Location.new(0, 0) }
      before(:each) do
        @test_grid = Grid.new
      end

      context "when there is no cell at a location" do
        it "returns false" do
          expect(@test_grid.cell_exists_at?(test_location)).to be false
        end
      end

      context "when there is a cell at a location" do
        it "returns true if the cell is dead" do
          @test_grid.spawn_cell_at(test_location)
          @test_grid.kill_cell_at(test_location)
          expect(@test_grid.cell_exists_at?(test_location)).to be true
        end

        it "returns true if the cell is alive" do
          @test_grid.spawn_cell_at(test_location)
          expect(@test_grid.cell_exists_at?(test_location)).to be true
        end
      end
    end

    describe "#number_of_living_neighbors" do

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

      context "when there are no living cells" do
        it "returns true immediately after creation" do
          expect(Grid.new.empty?).to be true
        end

        it "returns true when all existent cells are dead" do
          @test_grid.spawn_cell_at(@test_location)
          @test_grid.kill_cell_at(@test_location)
          expect(@test_grid.empty?).to be true
        end
      end

      context "when there is at least one living cell" do
        it "returns false" do
          @test_grid.spawn_cell_at(test_location)
          expect(@test_grid.empty?).to be false
        end
      end

    end
  end
end
