require 'grid_factory'
require 'runner'
require 'stringio'

describe Runner do
  let(:glider) do
    GridFactory.from_string_array(['_@_',
                                   '__@',
                                   '@@@'])
  end

  describe ".read_initial_state" do
    context "when the file exists" do
      it "stores the files content" do
        runner = Runner.new
        fake_io_with_input("states/glider.txt") do |fake_input, fake output|
          k
        end
      end
    end
  end
end
