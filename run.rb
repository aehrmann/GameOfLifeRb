#!/usr/bin/env ruby

require_relative './lib/grid_factory'
require_relative './lib/grid_formatter'
require_relative './lib/runner'

p ARGV

if ARGV.length == 1
  filename = ARGV[0]
  if File.exists?(filename)
    contents = File.read(filename)
    grid = GridFactory.from_parsed_input(contents)
  else
    puts "Can't find #{filename}. Check to make sure the file exists in the current directory."
    exit
  end
else
  puts "First argument should be a file name."
  exit
end

runner = Runner.new(grid)

runner.start
while runner.running?
  begin
    system "clear"
    puts "=" * 20
    puts (" " * 10) + grid.count_living_cells.to_s
    puts "=" * 20
    puts GridFormatter.new(grid).as_string
    grid = grid.tick
    if grid.all_cells_dead?
      runner.stop
    end
    sleep 0.1
  rescue Interrupt
    puts "Goodbye!"
    runner.stop
  end
end
