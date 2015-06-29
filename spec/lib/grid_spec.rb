require 'grid'

describe Grid do
  
  describe "#spawn_cell_at" do
    it "creates a living cell at the given row and column" do
      grid = Grid.new
      grid.spawn_cell_at(0, 0)
      expect(grid.live_cell_at?(0, 0)).to be true
    end
  end

  describe "#live_cell_at?" do
    let(:grid) { Grid.new }

    context "when there is a live cell at a location" do
      it "returns true" do
        grid.spawn_cell_at(1, 1)
        expect(grid.live_cell_at?(1, 1)).to be true
      end
    end

    context "when there is no cell at a location" do
      it "returns false" do
        expect(grid.live_cell_at?(1, 1)).to be false
      end
    end

    context "when there is a dead cell at a location" do
      it "returns false" do
        grid.spawn_cell_at(2, 2)
        grid.kill_cell_at(2, 2)
        expect(grid.live_cell_at?(2, 2)).to be false
      end
    end
  end
end
