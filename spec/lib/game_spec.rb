require 'game'
require 'grid_builder'
require 'grid_formatter'
require 'stringio'

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

    describe "one iteration" do
      it "outputs the current grid" do
        expected_string = GridFormatter.as_string(@game.grid)

        fake_output = StringIO.new
        $stdout = fake_output

        @game.iterate_once

        expect(fake_output.string).to match(expected_string)
        $stdout = STDOUT
      end
    end
  end
end

