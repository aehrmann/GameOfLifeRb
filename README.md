# Game of Life in Ruby
[Conway's Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life) in Ruby on the command line.

### Running the game
To run the game, use the `game-of-life` executable, passing an initial state file's name, which are located in the `states` directory. Here are the options:

- States that run indefinitely:
	- glider.txt
	- pulsar.txt
- States that run for a finite number of generations
	- acorn.txt
	- beacon.txt
	- diehard.txt

*Note: as of now, if a configuration never causes the grid to be empty, Ctrl-C is 
the only way to stop the game loop.*

### Running the tests
Run the `rspec` command with no arguments.