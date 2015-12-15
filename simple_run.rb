#! /usr/bin/env ruby

require './machine'

machine = Machine.new('programs/simple_down_counter_threaded.bmp')
200.times { machine.run_one_instruction }
puts
puts
puts machine.output
puts "Total cycles: #{machine.cycles}"