require './memory_wheel'

class PThread
  #parent of the thread, should be a machine
  attr_reader :parent
  #2d array of instructions
  attr_reader :instructions
  attr_reader :position_x, :position_y
  attr_reader :direction
  attr_reader :memory_wheel

  attr_accessor :stage_1, :stage_2

  attr_reader :paused, :paused_counter, :ended

  DIRECTIONS = [:up, :left, :down, :right]

  def initialize(parent, instructions, position_x, position_y, direction)
    @parent = parent
    @instructions = instructions
    @memory_wheel = MemoryWheel.new
    @position.x = position_x
    @position.y = position_y
    @direction = direction
    @stage_1 = 0
    @stage_2 = 0

    @paused = false
    @paused_counter = 0
    @ended = false
  end

  def run_one_instruction
    if paused
      @paused_counter -= 1
      if @paused_counter <= 0
        unpause
      end
      return
    end

    instruction = instructions[position_x, position_y]
    instruction.run(self, instruction.color_value)
    move 1
  end

  def change_direction(direction)
    throw ArgumentError.new unless DIRECTIONS.include? direction
    @direction = direction
  end

  def turn_left
    index = DIRECTIONS.index direction + 1
    index = 0 if index >= DIRECTIONS.length
    change_direction(DIRECTIONS[index])
  end

  def turn_right
    index = DIRECTIONS.index direction - 1
    index = DIRECTIONS.length-1 if index < 0
    change_direction(DIRECTIONS[index])
  end

  def reverse
    turn_left
    turn_left
  end

  def move amount
    case direction
      when :up
        position_y -= amount
      when :down
        position_y += amount
      when :left
        position_x -= amount
      when :right
        position_x += amount
      else
        throw ArgumentError.new
    end
  end

  def pause cycles
    @paused = true
    @paused_counter = cycles
  end

  def unpause
    @pause = false
    @paused_counter = 0
  end

  def kill
    @ended = true
  end
end