require 'grid_factory'
require 'runner'
require 'stringio'

describe Runner do
  let(:empty_grid) { GridFactory.empty_grid(10) }

  describe 'creating a runner' do
    it 'is initialized as not running' do
      runner = Runner.new(empty_grid)
      expect(runner.running?).to be false
    end

    it 'sets its output stream to STDOUT by default' do
      runner = Runner.new(empty_grid)
      expect(runner.out_stream).to eq(STDOUT)
    end

    it 'accepts an optional output stream' do
      mock_output = StringIO.new
      runner = Runner.new(empty_grid, mock_output)
      expect(runner.out_stream).to eq(mock_output)
    end

  end

  describe 'starting a game' do
    it 'sets itself to running' do
      grid = GridFactory.empty_grid(10)
      runner = Runner.new(grid)
      
      runner.start

      expect(runner.running?).to be true
    end
  end

  describe 'a step in the game' do
    before(:all) do
      @empty_grid = GridFactory.empty_grid(10)
      @mock_output = StringIO.new
      @runner = Runner.new(@empty_grid, @mock_output)
    end

    it 'keeps running if there are still live cells' do
      grid = GridFactory.from_string_array(['__@',
                                            '@@_',
                                            '@@_'])
      runner = Runner.new(grid, @mock_output)
      runner.start

      runner.step

      expect(runner.running?).to be true
    end

    it 'stops running if there are no live cells' do
      @runner.step

      expect(@runner.running?).to be false
    end

    it 'displays the grid' do
      mock_output = StringIO.new
      runner = Runner.new(GridFactory.empty_grid(10), mock_output)

      runner.step

      expect(mock_output.string.length).not_to eq(0)
    end
  end
end
