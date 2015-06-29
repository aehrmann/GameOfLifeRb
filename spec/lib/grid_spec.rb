require 'grid'

describe Grid do
  before(:each) do
    @grid = Grid.new
  end

  describe "#spawn_cell_at" do

    it "creates a living cell at the given row and column" do
      @grid.spawn_cell_at(0, 0)
      expect(@grid.live_cell_at?(0, 0)).to be true
    end
  end

  describe "checking the status of a cell" do

    describe "#live_cell_at?" do
      context "when there is a live cell at a location" do
        it "returns true" do
          @grid.spawn_cell_at(1, 1)
          expect(@grid.live_cell_at?(1, 1)).to be true
        end
      end

      context "when there is no cell at a location" do
        it "returns false" do
          expect(@grid.live_cell_at?(1, 1)).to be false
        end
      end

      context "when there is a dead cell at a location" do
        it "returns false" do
          @grid.spawn_cell_at(2, 2)
          @grid.kill_cell_at(2, 2)
          expect(@grid.live_cell_at?(2, 2)).to be false
        end
      end
    end

    describe "#cell_exists_at?" do

      context "when there is no cell at a location" do
        it "returns false" do
          expect(@grid.cell_exists_at?(0, 0)).to be false
        end
      end

      context "when there is a cell at a location" do
        it "returns true if the cell is dead" do
          @grid.spawn_cell_at(1, 1)
          @grid.kill_cell_at(1, 1)
          expect(@grid.cell_exists_at?(1, 1)).to be true
        end

        it "returns true if the cell is alive" do
          @grid.spawn_cell_at(2, 2)
          expect(@grid.cell_exists_at?(2, 2)).to be true
        end
      end
    end
  end
end
