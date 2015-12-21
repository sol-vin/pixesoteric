#! /usr/bin/env ruby

require './machine'

machine = Machine.new('programs/project_euler_5.bmp', "10")
10_000.times { machine.run_one_instruction }

#machine.run
puts
puts
puts machine.output
puts "Total cycles: #{machine.cycles}"