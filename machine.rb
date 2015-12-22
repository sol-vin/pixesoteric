require_relative './instruction'
require_relative './p_thread'
require_relative './instructions/basic/basic'

require 'rmagick'
require 'logger'
include Magick


class Machine
  #contains the active running threads on the machine
  attr_reader :threads
  #2d array of instructions
  attr_reader :instructions
  #output of the machine
  attr_reader :output
  #the number of completed cycles
  attr_reader :cycles
  #logger log
  attr_reader :log
  #name of the machine, is the file identifier of the image
  attr_reader :name
  #how many times has this machine been run
  attr_reader :runs
  #static memory for threads
  attr_reader :memory
  #input
  attr_reader :input

  def initialize(image_file, input='')
    @original_input = input
    @name = image_file.split('/').last.split('.').first
    @runs = 0
    @instructions = Instructions.new image_file
    reset #start the machine
  end

  #reset the machine
  def reset
    @cycles = 0
    @output = ''
    @to_merge = []
    @threads = []
    @id = 0
    @memory = {}
    @memory.default = Color.new(0)
    @input = @original_input

    @log = Logger.new(File.new(File.dirname(__FILE__) + '/log/' + name + '.log', 'w'))
    log.info "#{name} has reset! Runs: #{runs}"
    log.level = Logger::WARN

    @instructions.start_points.each do |sp|
      @threads << PThread.new(self, sp.x, sp.y, sp.p.class.direction)
    end

    @runs += 1
  end

  #runs until all threads are killed
  def run
    while threads.length > 0
      run_one_instruction
    end
  end
 
  #runs a single instruction on all threads
  def run_one_instruction
    return if threads.empty? and @to_merge.empty?
    threads.each do |thread|
      thread.run_one_instruction
    end
    #merge threads
    #threads end up in @to_merge from fork_thread and are added
    #after instructions are ran
    @to_merge.each do |hash|
      thread_index = -1

      threads.each_with_index do |thread, index|
        if thread.id == hash[:thread].id
          thread_index = index
        end
      end
      if hash[:direction] == :left
        threads.insert(thread_index, hash[:new_thread])
      elsif hash[:direction] == :right
        threads.insert(thread_index + 1, hash[:new_thread])
      end
    end
    @to_merge.clear

    #prune old threads, delete the ones that no longer are active
    @threads.select! { |t| !t.ended }
    @cycles += 1
  end

  #forks a thread in a specific direction
  def fork_thread(thread, turn_direction)
    new_thread = thread.clone

    if turn_direction == :left
      new_thread.turn_left
    elsif turn_direction == :right
      new_thread.turn_right
    end
    new_thread.move 1

    @to_merge << {thread: thread, new_thread: new_thread, direction: turn_direction}
    log.debug "^  Thread forked! Id: #{new_thread.id}"
  end

  #writes to the output
  def write_output(string)
    @output << string
  end

  def get_input_number
    string = ''
    while input.length != 0 && ('0'..'9').include?(input[0])
      string << @input.slice!(0)
    end
    string.to_i
  end

  def get_input_char
    @input.slice!(0).ord unless input.length == 0
  end

  def get_id
    new_id = @id
    @id += 1
    new_id
  end
end
