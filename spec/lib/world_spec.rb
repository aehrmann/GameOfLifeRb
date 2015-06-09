require 'world'

describe World do
  describe "creating a world" do
    let(:world) { World.new(5) }
    describe "#new" do
      it "creates a grid of cells with the given dimension" do
        expect(world.dimension).to eq(5)
      end

      it "sets all cells to dead" do
        all_dead = world.cells.all? do |row|
          row.all? { |cell| cell == false }
        end
        expect(all_dead).to be true
      end
    end
  end

  describe "checking a cell's living status" do
    before(:each) { @world = World.new(10) }

    it "returns false if there is no cell at the given coordinates" do
      expect(@world.living_cell?(2, 8)).to be false
    end

    it "returns true if there a cell at the given position" do
      @world.spawn_cell_at(5, 2)
      expect(@world.living_cell?(5, 2)).to be true
    end

    it "returns false if the coordinates are not within the world's bounds" do
      expect(@world.living_cell?(0, 20)).to be false
      expect(@world.living_cell?(20, 0)).to be false
      expect(@world.living_cell?(-10, 0)).to be false
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

  describe "finding cells to change" do
    it "returns no cell coordinates for an empty grid" do
      world = World.new(10)
      expect(world.cells_to_update).to eq([])
    end

    it "returns live cells with fewer than 2 living neighbors" do
      world = World.new(10)
      world.spawn_cell_at(1, 2)
      world.spawn_cell_at(4, 7)
      world.spawn_cell_at(3, 7)

      expect(world.cells_to_update).to include([1, 2])
      expect(world.cells_to_update).to include([4, 7])
    end

    it "returns live cells with more than 3 living neighbors" do
      world = World.new(10)
      world.spawn_cell_at(1, 3)

      world.spawn_cell_at(2, 2)
      world.spawn_cell_at(2, 3)
      world.spawn_cell_at(1, 2)
      world.spawn_cell_at(0, 2)

      expect(world.cells_to_update).to include([1, 3])
    end

    it "returns dead cells with exactly 3 living neighbors" do
      world = World.new(10)
      world.spawn_cell_at(0, 1)
      world.spawn_cell_at(1, 0)
      world.spawn_cell_at(1, 1)

      expect(world.cells_to_update).to include([0, 0])
    end
  end

  #describe "one tick" do
    #it "updates the appropriate cells" do
      #grid_before = Grid.from_strings(['@,_,_,@,_',
                                       #'_,@,_,@,_',
                                       #'_,_,_,@,@',
                                       #'_,_,_,@,@',
                                       #'@,_,_,@,_'])
      #grid_after = Grid.from_strings(['_,_,@,_,_',
                                      #'_,_,_@_,_',
                                      #'_,_,_,_,_',
                                      #'_,_,_,_,_',
                                      #'_,_,_,@,@'])
    #end
  #end
end
