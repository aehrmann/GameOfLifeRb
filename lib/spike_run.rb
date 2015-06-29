#! /usr/bin/env ruby

require 'spike_grid'

grid = SpikeGrid.new(%w{ _ @ _ },
                %w{ _ _ @ },
                %w{ @ @ @ })

formatter = SpikeFormatter.new(grid)

