#! /usr/bin/env ruby

require './machine'

machine = Machine.new('programs/hello_world.bmp')
puts machine.instructions.inspect