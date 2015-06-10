#!/usr/bin/env ruby

require_relative 'lib/grid_factory'

glider_contents = File.read("glider.txt")

grid = GridFactory.from_parsed_input(glider_contents)

running = true
while running
  begin
    system "clear"
    puts grid
    grid = grid.tick
    sleep 0.1
  rescue Interrupt
    system "clear"
    puts "Goodbye!"
    running = false
  end
end
