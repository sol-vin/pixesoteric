#! /usr/bin/env ruby

require './machine'

machine = Machine.new('programs/fibonacci.bmp')
400.times { machine.run_one_instruction }
puts
puts
puts machine.output