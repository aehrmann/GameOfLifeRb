#!/usr/bin/env ruby

# runner with step method, test after individual steps

require_relative 'lib/grid_factory'
require_relative 'lib/grid_formatter'

glider_contents = File.read("glider.txt")

grid = GridFactory.from_parsed_input(glider_contents)

running = true
while running
  begin
    system "clear"
    puts GridFormatter.new(grid).as_string
    grid = grid.tick
    sleep 0.1
  rescue Interrupt
    system "clear"
    puts "Goodbye!"
    running = false
  end
end
