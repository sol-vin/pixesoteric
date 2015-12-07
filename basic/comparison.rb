require_relative '../instruction.rb'
require_relative '../colors.rb'

class GreaterThanZero < Instruction
  class << self
    def pattern
      [
          [Colors.BLACK, Colors.BLACK, Colors.WHITE],
          [Colors.BLACK, Colors.WHITE, Colors.WHITE],
          [Colors.BLACK, Colors.WHITE, Colors.WHITE],
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

class S1GreaterThanS2 < Instruction
  class << self
    def pattern
      [
          [Colors.BLACK, Colors.WHITE, Colors.WHITE],
          [Colors.BLACK, Colors.WHITE, Colors.WHITE],
          [Colors.BLACK, Colors.BLACK, Colors.WHITE],
      ]
    end

    def run(thread, color_value)
      if thread.memory_wheel.stage_1 > thread.memory_wheel.stage_1
        thread.memory_wheel.push 1
      else
        thread.memory_wheel.push 0
      end
    end
  end
end
