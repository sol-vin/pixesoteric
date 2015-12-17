#! /usr/bin/env ruby

require './machine'

machine = Machine.new('programs/static_increment.bmp')
20000.times { machine.run_one_instruction }
puts
puts
puts machine.output
puts "Total cycles: #{machine.cycles}"