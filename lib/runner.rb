require 'grid_formatter'

class Runner
  attr_reader :grid, :out_stream
  attr_accessor :running

  def initialize(grid, out_stream = nil)
    @grid = grid
    @running = false
    @out_stream = out_stream || STDOUT
  end

  def running?
    running
  end

  def start
    self.running = true
  end

  def step
    if grid.all_cells_dead?
      self.running = false
    end
    out_stream.puts GridFormatter.new(grid).as_string
  end
end
