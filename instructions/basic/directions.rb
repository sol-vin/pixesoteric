require_relative '../../instruction.rb'
require_relative '../../colors.rb'

# Changes the direction of the thread to up.
class DirectionUp < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::BLACK, Colors::WHITE],
          [Colors::WHITE, Colors::BLACK, Colors::WHITE],
          [Colors::WHITE, Colors::WHITE, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      thread.change_direction :up
    end
  end
end

# Changes the direction of the thread to down.
class DirectionDown < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::WHITE, Colors::WHITE],
          [Colors::WHITE, Colors::BLACK, Colors::WHITE],
          [Colors::WHITE, Colors::BLACK, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      thread.change_direction :down
    end
  end
end

# Changes the direction of the thread to left.
class DirectionLeft < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::WHITE, Colors::WHITE],
          [Colors::BLACK, Colors::BLACK, Colors::WHITE],
          [Colors::WHITE, Colors::WHITE, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      thread.change_direction :left
    end
  end
end

# Changes the direction of the thread to right.
class DirectionRight < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::WHITE, Colors::WHITE],
          [Colors::WHITE, Colors::BLACK, Colors::BLACK],
          [Colors::WHITE, Colors::WHITE, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      thread.change_direction :right
    end
  end
end