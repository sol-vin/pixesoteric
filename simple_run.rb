#! /usr/bin/env ruby

require './machine'

machine = Machine.new('programs/project_euler_1.bmp')
22000.times { machine.run_one_instruction }
puts
puts
puts machine.output
puts "Total cycles: #{machine.cycles}"