require_relative '../../instruction'
require_relative '../../colors'

# Compares the CMWL to the color value of the instruction.
# Pushes TRUE if CMWL > CV
# Pushes FALSE if CMWL <= CV
class GreaterThanCV < Instruction
  class << self
    def pattern
      [
          [Colors::BLACK, Colors::BLACK, Colors::WHITE],
          [Colors::BLACK, Colors::WHITE, Colors::WHITE],
          [Colors::BLACK, Colors::WHITE, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      if thread.memory_wheel.pull.to_i > color_value.to_i
        thread.memory_wheel.push Instruction::LOGICAL_TRUE
      else
        thread.memory_wheel.push Instruction::LOGICAL_FALSE
      end
    end
  end
end

# Compares stage_1 to stage_2 via greater than (>).
# Pushes TRUE if stage_1 > stage_2
# Pushes FALSE if stage_1 <= stage_2
class S1GreaterThanS2 < Instruction
  class << self
    def pattern
      [
          [Colors::BLACK, Colors::WHITE, Colors::WHITE],
          [Colors::BLACK, Colors::WHITE, Colors::WHITE],
          [Colors::BLACK, Colors::BLACK, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      if thread.stage_1.to_i > thread.stage_2.to_i
        thread.memory_wheel.push Instruction::LOGICAL_TRUE
      else
        thread.memory_wheel.push Instruction::LOGICAL_FALSE
      end
    end
  end
end

# Compares stage_1 to stage_2 via is equal(==).
# Pushes TRUE if stage_1 == stage_2
# Pushes FALSE if stage_1 != stage_2
class S1EqualsS2 < Instruction
  class << self
    def pattern
      [
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
          [Colors::WHITE, Colors::WHITE, Colors::WHITE],
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
      ]
    end

    def run(thread, color_value)
      if thread.stage_1.to_i == thread.stage_2.to_i
        thread.memory_wheel.push Instruction::LOGICAL_TRUE
      else
        thread.memory_wheel.push Instruction::LOGICAL_FALSE
      end
    end
  end
end
