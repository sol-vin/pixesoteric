#! /usr/bin/env ruby

require './machine'

machine = Machine.new('programs/a_to_z.bmp')
machine.run
puts
puts
puts machine.output