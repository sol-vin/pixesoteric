require_relative './instruction'
require_relative './p_thread'
require_relative './instructions/basic/basic'

require 'rmagick'
include Magick


class Machine
  #contains the active running threads on the machine
  attr_reader :threads
  #2d array of instructions
  attr_reader :instructions
  #output of the machine
  attr_reader :output

  def initialize(image_file)
    @instructions = Instructions.new image_file
    reset #start the machine
  end
  
  #reset the machine
  def reset
    @output = ""
    @to_merge = {}
    @threads = []

    @instructions.start_points.each do |sp|
      @threads << PThread.new(self, sp.x, sp.y, sp.p.class.direction)
    end
  end

  #runs until all threads are killed
  def run
    while threads.length > 0
      run_one_instruction
    end
  end
 
  #runs a single instruction on all threads
  def run_one_instruction
    threads.each do |thread|
      thread.run_one_instruction
    end
    #merge threads
    #threads end up in @to_merge from fork_thread and are added
    #after instructions are ran
    @to_merge.each do |thread, turn_direction|
      thread_index = threads.index(thread)
      if turn_direction == :left
        threads.insert(thread_index, thread)
      elsif turn_direction == :right
        threads.insert(thread_index + 1, thread)
      end
    end

    #prune old threads, delete the ones that no longer are active
    @threads.select! { |t| !t.ended }
  end

  #forks a thread in a specific direction
  def fork_thread(thread, turn_direction)
    new_thread = thread.clone

    if turn_direction == :left
      new_thread.turn_left
    elsif turn_direction == :right
      new_thread.turn_right
    end

    @to_merge[new_thread] = turn_direction
  end

  #writes to the output
  def write_output string
    @output << string
  end
end
