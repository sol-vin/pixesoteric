#! /usr/bin/env ruby

require './machine'

machine = Machine.new('programs/is_palindrome.bmp', "984489")
10000.times { machine.run_one_instruction }

#machine.run
puts
puts
puts machine.output
puts "Total cycles: #{machine.cycles}"