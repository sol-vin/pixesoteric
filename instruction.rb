require_relative './instructions'
require_relative './colors'

# Base class for instructions to be read into by the interpreter.
class Instruction
  # height and width of the pattern
  PATTERN_SIZE = 3
  # number of tiles in the pattern
  PATTERN_TILES = PATTERN_SIZE**2

  LOGICAL_FALSE = 0
  LOGICAL_TRUE = 1

  # color value of the instruction
  # color_value is used in a variety of commands to expand functionality
  attr_accessor :color_value

  def initialize(cv)
    @color_value = cv
  end

  # runs the instruction by calling the class level run
  def run(thread, cv)
    self.class.run(thread, cv)
  end

  class << self
    # check a pattern to this instruction to see if it matches
    def check_pattern(pattern2)
      PATTERN_SIZE.times do |y|
        PATTERN_SIZE.times do |x|
          both_white = (pattern[x][y] == Colors::WHITE && pattern2[x][y] == Colors::WHITE)
          both_not_white = (pattern[x][y] != Colors::WHITE && pattern2[x][y] != Colors::WHITE)
          return false unless both_white || both_not_white
        end
      end
      true
    end

    # gets the color_value of the instruction
    def get_color_value(pattern)
      PATTERN_SIZE.times do |y|
        PATTERN_SIZE.times do |x|
          return pattern[x][y] unless pattern[x][y] == Colors::WHITE
        end
      end
      Colors::WHITE
    end

    # runs the instruction on a thread
    def run(thread, color_value)
      # dont do anything until someone gives us direction
    end

    # automatically place the instruction class into Instructions
    # so it can test read patterns against the instruction set easily.
    def inherited(i)
      # Add our class to the list of instructions
      Instructions.add_instruction(i)
    end
  end
end
