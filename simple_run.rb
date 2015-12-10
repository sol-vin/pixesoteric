#! /usr/bin/env ruby

require './machine'

machine = Machine.new('programs/simple_up_counter.bmp')
machine.run
puts
puts
puts machine.output