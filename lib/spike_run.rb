require_relative 'spike_grid'
require_relative 'spike_grid_formatter'

if ARGV.length == 1
  filename = ARGV[0]
  if File.exists?(filename)
    contents = File.read(filename)
    state = contents.split("\n")
    grid_height = state.count
    grid_width = state[0].length
    grid = SpikeGrid.from_state(state)
  else
    puts "Can't find #{filename}. Check to make sure the file exists in the current directory."
    exit
  end
else
  puts "First argument should be a file name."
  exit
end

generations = 0
should_stop = false
puts GridFormatter.new(grid, grid_height, grid_width).as_string

def display_grid_and_info(grid, generations, grid_height = 0, grid_width = 0)
  display_string = GridFormatter.new(grid, grid_height, grid_width).as_string
  system "clear"
  puts "=" * 60
  puts (" " * 10) + "Living cells: " + grid.living_cell_count.to_s + " - Generation # #{generations}"
  puts "=" * 60
  puts display_string
  sleep 0.2
end

display_grid_and_info(grid, generations, grid_height / 2, grid_width / 2)

until should_stop
  begin
    generations += 1
    grid = grid.tick
    display_grid_and_info(grid, generations, grid_height / 2, grid_width / 2)
    if grid.living_cell_count == 0
      should_stop = true
    end
  rescue Interrupt
    puts "Goodbye!"
    should_stop = true
  end
end
