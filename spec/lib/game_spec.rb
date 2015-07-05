require 'game'
require 'grid_builder'
require_relative './mocks/mock_terminal_display'

def fake_file_read(filename, contents)
  allow(File).to receive(:open).with(filename).and_return(StringIO.new(contents))
end

describe Game do

  before(:each) do
    fake_file_read("test_state.txt", "___\n@@@\n")
    mock_terminal = MockTerminalDisplay.new
    @game = Game.new("test_state.txt", mock_terminal)
  end

  describe "loading a file" do
    it "creates a grid based on an initial state file" do
      expected_grid = GridBuilder.from_initial_state(["___",
                                                      "@@@"])
      expect(@game.grid).to eq(expected_grid)
    end
  end

  describe "the main loop" do

    describe "one iteration" do

      before(:each) do
        @game.iterate_once
      end

      it "outputs the number of living cells" do
        expect(@game.display.display_grid_was_called).to be true
      end

      it "outputs the current grid" do
        expect(@game.display.display_grid_was_called).to be true
      end

      it "clears the screen during each iteration" do
        expect(@game.display.clear_screen_was_called).to be true
      end

      it "pauses during the iteration" do
        expect(@game.display.pause_was_called).to be true
      end
    end

    describe "updating the grid" do
      it "generates a new grid" do
        expected_grid = @game.grid.next_generation
        @game.iterate_once
        expect(@game.grid).to eq(expected_grid)
      end
    end

    it "runs until the grid is empty" do
      fake_file_read("short_duration_state.txt", "@\n@\n")
      @game = Game.new("short_duration_state.txt", MockTerminalDisplay.new)

      @game.run_loop

      expect(@game.grid.empty?).to be true
    end
  end

end
