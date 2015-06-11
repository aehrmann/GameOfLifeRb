#!/usr/bin/env ruby

# runner with step method, test after individual steps

require_relative 'lib/grid_factory'
require_relative 'lib/grid_formatter'
require_relative 'lib/runner'

if ARGV.length == 2
  filename = ARGV[1]
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
    puts GridFormatter.new(grid).as_string
    grid = grid.tick
    sleep 0.1
  rescue Interrupt
    system "clear"
    puts "Goodbye!"
    runner.stop
  end
end
