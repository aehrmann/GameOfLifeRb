require 'grid'

describe Grid do

  describe "#spawn_cell_at" do
    before(:each) do
      @grid = Grid.new
    end

    it "creates a living cell at a given location" do
      location = Location.new(0, 0)
      @grid.spawn_cell_at(location)
      expect(@grid.live_cell_at?(location)).to be true
    end
  end

  describe "checking the status of a cell at a location" do
    let(:a_location) { Location.new(1, 1) }

    before(:each) do
      @grid = Grid.new
    end

    describe "#live_cell_at?" do
      context "when there is a live cell at a location" do
        it "returns true" do
          @grid.spawn_cell_at(a_location)
          expect(@grid.live_cell_at?(a_location)).to be true
        end
      end

      context "when there is no cell at a location" do
        it "returns false" do
          expect(@grid.live_cell_at?(a_location)).to be false
        end
      end

      context "when there is a dead cell at a location" do
        it "returns false" do
          @grid.spawn_cell_at(a_location)
          @grid.kill_cell_at(a_location)
          expect(@grid.live_cell_at?(a_location)).to be false
        end
      end
    end

    describe "#cell_exists_at?" do
      let(:a_location) { Location.new(0, 0) }
      before(:each) do
        @grid = Grid.new
      end

      context "when there is no cell at a location" do
        it "returns false" do
          expect(@grid.cell_exists_at?(a_location)).to be false
        end
      end

      context "when there is a cell at a location" do
        it "returns true if the cell is dead" do
          @grid.spawn_cell_at(a_location)
          @grid.kill_cell_at(a_location)
          expect(@grid.cell_exists_at?(a_location)).to be true
        end

        it "returns true if the cell is alive" do
          @grid.spawn_cell_at(a_location)
          expect(@grid.cell_exists_at?(a_location)).to be true
        end
      end
    end
  end
end
