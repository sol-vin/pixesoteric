require './instruction'
require './pattern'
require 'basic/basic'

require 'rmagick'
include Magick


class Machine
  attr_reader :threads
  attr_reader :instructions
  attr_reader :output

  def initialize(image_file)
    @instructions = Instructions.new image_file
    @output = ""
  end

  def run_one_instruction

  end

  def fork_thread(thread, direction)

  end

  def write_output char
    @output << char
  end
end