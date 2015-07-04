require 'grid_builder'
require 'grid_formatter'
require 'terminal_display'

def with_fake_output
  fake_output = StringIO.new
  $stdout = fake_output

  yield(fake_output)

  $stdout = STDOUT
end

describe TerminalDisplay do
  let(:blank_screen_string) do
    screen_rows, screen_columns = IO.console.winsize
    ((' ') * screen_columns) * screen_rows
  end

  before(:each) do
    @terminal = TerminalDisplay.new
  end

  let(:glider) do
    GridBuilder.from_initial_state([
      "_@_",
      "__@",
      "@@@"
    ])
  end

  describe "clearing the screen" do
    it "prints the clear screen escape code" do
      with_fake_output do |output|
        @terminal.clear_screen
        expect(output.string).to include("\e[1;1H")
      end
    end

    it "prints all spaces to the terminal" do
      with_fake_output do |output|
        @terminal.display_blank_screen
        expect(output.string).to match(blank_screen_string)
      end
    end
  end

  describe "displaying a grid" do
    it "displays the grid as a string" do
      expected_output = GridFormatter.as_string(glider)

      with_fake_output do |output|
        @terminal.display_grid(glider)
        expect(output.string).to match(expected_output)
      end
    end
  end

  describe "pausing" do
    it "calls system sleep" do
      allow(Kernel).to receive(:sleep)
      @terminal.pause
      expect(Kernel).to have_received(:sleep)
    end
  end
end
