require_relative './instructions'
require_relative './colors'

class Instruction

  PATTERN_SIZE = 3
  PATTERN_TILES = PATTERN_SIZE**2

  attr_accessor :color_value

  def initialize cv
    color_value = Color.new(cv)
  end


  class << self
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


    def get_color_value(pattern)
      PATTERN_SIZE.times do |y|
        PATTERN_SIZE.times do |x|
          return pattern[x][y] unless pattern[x][y] == 0xffffff
        end
      end
    end

    def run(thread, color_value)
      #dont do anything until someone gives us direction
    end

    def inherited i
      #Add our class to the list of instructions
      Instructions.add_instruction(i)
    end
  end
end
