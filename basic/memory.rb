require_relative '../instruction.rb'
require_relative '../colors.rb'

class MemWheelRight < Instruction
  class << self
    def pattern
      [
          [Colors.WHITE, Colors.BLACK, Colors.WHITE],
          [Colors.WHITE, Colors.WHITE, Colors.BLACK],
          [Colors.WHITE, Colors.BLACK, Colors.WHITE],
      ]
    end

    def run(thread, color_value)
      (color_value.to_i + 1).times { thread.memory_wheel.move_right }
    end
  end
end

class MemWheelLeft < Instruction
  class << self
    def pattern
      [
          [Colors.WHITE, Colors.BLACK, Colors.WHITE],
          [Colors.BLACK, Colors.WHITE, Colors.WHITE],
          [Colors.WHITE, Colors.BLACK, Colors.WHITE],
      ]
    end

    def run(thread, color_value)
      (color_value.to_i + 1).times { thread.memory_wheel.move_left }
    end
  end
end

class Decrement < Instruction
  class << self
    def pattern
      [
          [Colors.WHITE, Colors.WHITE, Colors.WHITE],
          [Colors.BLACK, Colors.WHITE, Colors.BLACK],
          [Colors.WHITE, Colors.BLACK, Colors.WHITE],
      ]
    end

    def run(thread, color_value)
      thread.memory_wheel.push(thread.memory_wheel.pull.to_i - (color_value.to_i + 1))
    end
  end
end

class Increment < Instruction
  class << self
    def pattern
      [
          [Colors.WHITE, Colors.BLACK, Colors.WHITE],
          [Colors.BLACK, Colors.WHITE, Colors.BLACK],
          [Colors.WHITE, Colors.WHITE, Colors.WHITE],
      ]
    end

    def run(thread, color_value)
      thread.memory_wheel.push(thread.memory_wheel.pull.to_i + (color_value.to_i + 1))
    end
  end
end

class Insert < Instruction
  class << self
    def pattern
      [
          [Colors.WHITE, Colors.WHITE, Colors.WHITE],
          [Colors.BLACK, Colors.WHITE, Colors.WHITE],
          [Colors.BLACK, Colors.BLACK, Colors.WHITE],
      ]
    end

    def run(thread, color_value)
      thread.memory_wheel.push(color_value)
    end
  end
end

