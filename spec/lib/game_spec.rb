require 'game'
require 'grid_builder'
require 'grid_formatter'
require 'stringio'
require 'io/console'

def with_fake_output
  fake_output = StringIO.new
  $stdout = fake_output
  yield fake_output
  $stdout = STDOUT
end

describe Game do

  before(:each) do
    fake_file = StringIO.new("___\n@@@\n")
    allow(File).to receive(:open).with("test_state.txt").and_return(fake_file)

    @game = Game.new("test_state.txt")
  end

  describe "loading a file" do
    it "creates a grid based on an initial state file" do
      expected_grid = GridBuilder.from_initial_state(["___",
                                                      "@@@"])
      expect(@game.grid).to eq(expected_grid)
    end
  end

  describe "the main loop" do
    let(:clear_string) do
      rows, cols = IO.console.winsize
      (' ' * cols) * rows + "\n"
    end

    describe "one iteration" do
      it "outputs the current grid" do
        expected_string = GridFormatter.as_string(@game.grid)

        with_fake_output do |output|
          @game.iterate_once

          expect(output.string).to match(expected_string)
        end
      end

      it "clears the screen during each iteration" do
        grid_string = GridFormatter.as_string(@game.grid)

        expected_string = clear_string + grid_string

        with_fake_output do |output|
          @game.iterate_once
          expect(output.string).to match(expected_string)
        end
      end

      it "generates a new grid" do
        expected_grid = @game.grid.tick
        with_fake_output do
          @game.iterate_once
          expect(@game.grid).to eq(expected_grid)
        end
      end
    end

    describe "running the main loop" do
      it "runs until the grid is empty" do
        fake_file = StringIO.new("@\n@\n")
        allow(File).to receive(:open).with("test_state.txt").and_return(fake_file)

        @game = Game.new("test_state.txt")

        with_fake_output do
          @game.run_loop
          expect(@game.grid.empty?).to be true
        end
      end
    end
  end
end

