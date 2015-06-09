require 'world'

describe World do
  describe "checking a cell's living status" do
    before(:each) { @world = World.new(10) }

    it "returns false if there is no cell at the given coordinates" do
      expect(@world.living_cell?(2, 8)).to be false
    end

    it "returns true if there a cell at the given position" do
      @world.spawn_cell_at(5, 2)
      expect(@world.living_cell?(5, 2)).to be true
    end
  end

  describe "retrieving the number of living neighbors for a cell" do
    before(:each) { @world = World.new(10) }

    it "returns 0 for a cell with no living neighbors" do
      expect(@world.count_living_neighbors(1, 9)).to eq(0)
    end

    it "returns the number of living neighbors in the row above the given cell" do
      @world.spawn_cell_at(3, 3)
      @world.spawn_cell_at(3, 4)
      @world.spawn_cell_at(3, 5)
      expect(@world.count_living_neighbors(4, 4)).to eq(3)
    end

    it "returns the number of living neighbors in the same row as the given cell" do
      @world.spawn_cell_at(1, 4)
      @world.spawn_cell_at(1, 6)
      expect(@world.count_living_neighbors(1, 5)).to eq(2)
    end

    it "returns the number of living neighbors in the row below the given cell" do
      @world.spawn_cell_at(8, 7)
      @world.spawn_cell_at(8, 8)
      @world.spawn_cell_at(8, 9)
      expect(@world.count_living_neighbors(7, 8)).to eq(3)
    end
  end
end
