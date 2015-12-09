require_relative '../../instruction.rb'
require_relative '../../colors.rb'

class VerticalIf < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::BLACK, Colors::WHITE],
          [Colors::WHITE, Colors::BLACK, Colors::WHITE],
          [Colors::WHITE, Colors::BLACK, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      if thread.memory_wheel.pull <= color_value.to_i
        thread.change_direction :down
      else
        thread.change_direction :up
      end
    end
  end
end

class HorizontalIf < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::WHITE, Colors::WHITE],
          [Colors::WHITE, Colors::WHITE, Colors::WHITE],
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
      ]
    end

    def run(thread, color_value)
      if thread.memory_wheel.pull <= color_value.to_i
        thread.change_direction :right
      else
        thread.change_direction :left
      end
    end
  end
end
