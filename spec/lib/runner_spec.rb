require 'runner'

describe Runner do
  describe 'creating a runner' do
    it 'is initialized as not running' do
      runner = Runner.new
      expect(runner.running?).to be false
    end
  end

end
