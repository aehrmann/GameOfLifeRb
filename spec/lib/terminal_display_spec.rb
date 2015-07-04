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
    it "clears the screen" do
      with_fake_output do |output|
        @terminal.clear_screen
        expect(output.string).to eq("\e[1;1H")
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

  describe "displaying a blank screen" do
    it "prints all spaces to the terminal" do
      with_fake_output do |output|
        @terminal.display_blank_screen
        expect(output.string).to match(blank_screen_string)
      end
    end
  end
end
