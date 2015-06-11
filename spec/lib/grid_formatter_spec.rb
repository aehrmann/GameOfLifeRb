require 'grid_formatter'
require 'grid_factory'

describe GridFormatter do
  describe "displaying a grid" do
    it "displays a grid with an odd dimension" do
      grid = GridFactory.from_string_array(['@____',
                                            '__@__',
                                            '@@@@@',
                                            '@@_@_',
                                            '____@'])
      formatter = GridFormatter.new(grid)

      expected_output = ""
      expected_output += "===================\n"
      expected_output += "|-----------------|\n"
      expected_output += "|-----------------|\n"
      expected_output += "|----@------------|\n"
      expected_output += "|--------@--------|\n"
      expected_output += "|----@-@-@-@-@----|\n"
      expected_output += "|----@-@---@------|\n"
      expected_output += "|------------@----|\n"
      expected_output += "|-----------------|\n"
      expected_output += "|-----------------|\n"
      expected_output += "===================\n"

      expect(formatter.as_string).to eq(expected_output)
    end

    it 'displays a grid with an even dimension' do
      grid = GridFactory.from_string_array(['__@___',
                                            '____@_',
                                            '__@_@@',
                                            '__@@_@',
                                            '____@_',
                                            '@_____'])
      formatter = GridFormatter.new(grid)

      expected_output = ""
      expected_output += "=====================\n"
      expected_output += "|-------------------|\n"
      expected_output += "|-------------------|\n"
      expected_output += "|--------@----------|\n"
      expected_output += "|------------@------|\n"
      expected_output += "|--------@---@-@----|\n"
      expected_output += "|--------@-@---@----|\n"
      expected_output += "|------------@------|\n"
      expected_output += "|----@--------------|\n"
      expected_output += "|-------------------|\n"
      expected_output += "|-------------------|\n"
      expected_output += "=====================\n"
      expect(formatter.as_string).to eq(expected_output)
    end
  end
end
