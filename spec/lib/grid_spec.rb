require 'grid'

describe Grid do
  
  describe "#spawn_cell_at" do
    it "creates a living cell at the given row and column" do
      grid = Grid.new
      grid.spawn_cell_at(0, 0)
      expect(grid.live_cell_at?(0, 0)).to be true
    end
  end
end
