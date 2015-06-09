require 'world'

describe World do
  describe "checking a cell's living status" do
    it "returns false if there is no cell at the given coordinates" do
      world = World.new(10)
      expect(world.living_cell?(2, 2)).to be false
    end

    it "returns true if there a cell at the given position" do
      world = World.new(10)
      world.spawn_cell_at(5, 5)
      expect(world.living_cell?(5, 5)).to be true
    end
  end
end
