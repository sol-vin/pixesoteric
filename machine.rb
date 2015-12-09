require_relative './instruction'
require_relative './p_thread'
require_relative './instructions/basic/basic'

require 'rmagick'
include Magick


class Machine
  attr_reader :threads
  attr_reader :instructions
  attr_reader :output

  def initialize(image_file)
    @instructions = Instructions.new image_file

    @output = ""
    @to_merge = {}
    @threads = []

    @instructions.start_points.each do |sp|
      @threads << PThread.new(self, instructions, sp.x, sp.y, sp.p.class.direction)
    end
  end

  def run
    while threads.length > 0
      run_one_instruction
    end
  end

  def run_one_instruction
    threads.each do |thread|
      thread.run_one_instruction
    end
    #merge threads
    @to_merge.each do |thread, turn_direction|
      thread_index = threads.index(thread)
      if turn_direction == :left
        threads.insert(thread_index, thread)
      elsif turn_direction == :right
        threads.insert(thread_index + 1, thread)
      end
    end

    #prune old threads
    @threads.select! { |t| !t.ended }
  end

  def fork_thread(thread, turn_direction)
    new_thread = thread.clone

    if turn_direction == :left
      new_thread.turn_left
    elsif turn_direction == :right
      new_thread.turn_right
    end

    @to_merge[new_thread] = turn_direction
  end

  def write_output char
    @output << char
  end
end