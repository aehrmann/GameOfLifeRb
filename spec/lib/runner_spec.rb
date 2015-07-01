require 'runner'
require 'grid_builder'
require 'grid_formatter'

def with_fake_output
  fake_output = StringIO.new
  $stdout = fake_output
  yield(fake_output)
  $stdout = STDOUT
end

describe Runner do
  describe "starting the runner" do
    it "prints the list of initial grid options at the beginning" do
      runner = Runner.new
      expected_output =<<-eos.gsub(/^\s+/, '')
      Welcome to the Game of Life!

      Please select an initial state for the game:
      1) Glider
      2) Pulsar
      3) Diehard
      4) Acorn
      5) Beacon

      Your choice: 
      eos
      with_fake_output do |output|
        runner.display_options
        expect(output.string).to match(expected_output)
      end
    end


    context "when the user's choice is valid" do
      it "parses the user's choice" do
        runner = Runner.new
        fake_input = StringIO.new("2\n")
        $stdin = fake_input

        user_choice = runner.get_user_choice

        $stdin = STDIN
        expect(user_choice).to eq(2)
      end
    end

    it "loads the correct file based on the user's choice" do
    end
    it "parses that file to create the initial grid" 
    it "begins in a non-running state"
  end

  describe "the main loop of the game" do
    it "enters a running state"
    it "displays the grid for every iteration"
    it "displays the number of living cells every iteration"
    it "stops running when the grid is empty"
    it "stops running if the user signals an interrupt"
  end
end

