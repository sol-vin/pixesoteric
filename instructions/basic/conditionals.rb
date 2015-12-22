require_relative '../../instruction.rb'
require_relative '../../colors.rb'

# Changes the direction of the thread to up or down depending on CMWL.
# Goes up if CMWL >= CV
# Goes down if CMWL < CV
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
      if thread.memory_wheel.pull.to_i >= color_value.to_i
        thread.change_direction :down
      else
        thread.change_direction :up
      end
    end
  end
end

# Changes the direction of the thread to left or right depending on CMWL.
# Goes left if CMWL >= CV
# Goes right if CMWL < CV
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
      if thread.memory_wheel.pull.to_i >= color_value.to_i
        thread.change_direction :left
      else
        thread.change_direction :right
      end
    end
  end
end
