require 'grid_formatter'
require 'grid_factory'

describe GridFormatter do
  describe "displaying a grid" do
    it "displays a grid with padding on all sides" do
      grid = GridFactory.from_string_array(['_____',
                                            '__@__',
                                            '@@@@@',
                                            '@@_@_',
                                            '____@'])
      formatter = GridFormatter.new(grid)

      expected_output = ""
      expected_output += "=================\n"
      expected_output += "|---------------|\n"
      expected_output += "|---------------|\n"
      expected_output += "|---------------|\n"
      expected_output += "|-------@-------|\n"
      expected_output += "|---@-@-@-@-@---|\n"
      expected_output += "|---@-@---@-----|\n"
      expected_output += "|-----------@---|\n"
      expected_output += "|---------------|\n"
      expected_output += "|---------------|\n"
      expected_output += "=================\n"

      expect(formatter.as_string).to eq(expected_output)
    end
  end
end
