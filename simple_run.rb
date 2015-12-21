#! /usr/bin/env ruby

require './machine'

machine = Machine.new('programs/factorial.bmp', "10")
200_000.times { machine.run_one_instruction }

#machine.run
puts
puts
puts machine.output
puts "Total cycles: #{machine.cycles}"