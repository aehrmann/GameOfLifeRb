#!/usr/bin/env ruby

$:.unshift(File.dirname(__FILE__) + '/lib')

require_relative 'lib/grid_formatter'
require_relative 'lib/grid_builder'
require_relative 'lib/grid'
require_relative 'lib/game'

Game.new(ARGV[0]).run_loop
