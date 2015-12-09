require_relative '../../instruction'
require_relative '../../colors'

class LogicalNot < Instruction
  class << self
    def pattern
      [
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
          [Colors::WHITE, Colors::WHITE, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      if thread.memory_wheel.pull > 0
        thread.memory_wheel.push 0
      else
        thread.memory_wheel.push 1
      end
    end
  end
end

class LogicalAnd < Instruction
  class << self
    def pattern
      [
          [Colors::BLACK, Colors::BLACK, Colors::WHITE],
          [Colors::BLACK, Colors::BLACK, Colors::WHITE],
          [Colors::BLACK, Colors::BLACK, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      if stage_1 > 0 && stage_2 > 0
        thread.memory_wheel.push 1
      else
        thread.memory_wheel.push 0
      end
    end
  end
end

class LogicalOr < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::BLACK, Colors::BLACK],
          [Colors::WHITE, Colors::BLACK, Colors::BLACK],
          [Colors::WHITE, Colors::BLACK, Colors::BLACK],
      ]
    end

    def run(thread, color_value)
      if stage_1 > 0 || stage_2 > 0
        thread.memory_wheel.push 1
      else
        thread.memory_wheel.push 0
      end
    end
  end
end

class LogicalXor < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::WHITE, Colors::WHITE],
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
      ]
    end

    def run(thread, color_value)
      if stage_1 > 0 ^ stage_2 > 0
        thread.memory_wheel.push 1
      else
        thread.memory_wheel.push 0
      end
    end
  end
end