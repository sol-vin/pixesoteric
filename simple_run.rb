#! /usr/bin/env ruby

require './machine'

machine = Machine.new('programs/is_prime.bmp', "1001")
1000000.times { machine.run_one_instruction }

#machine.run
puts
puts
puts machine.output
puts "Total cycles: #{machine.cycles}"