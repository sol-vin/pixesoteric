#! /usr/bin/env ruby
require 'logger'

require './machine'

time = Time.now
machine = Machine.new('programs/project_euler_4.bmp', '999')
#10_000.times { machine.run_one_instruction }
machine.run
delta = Time.now - time
puts
puts
puts machine.output
puts "Total cycles: #{machine.cycles}"
puts "Total time: #{delta}"