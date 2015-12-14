#! /usr/bin/env ruby

require './machine'

machine = Machine.new('programs/a_to_z.bmp')
600.times { machine.run_one_instruction }
puts
puts
puts machine.output
puts "Total cycles: #{machine.cycles}"