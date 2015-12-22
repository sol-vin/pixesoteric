require_relative '../../instruction'
require_relative '../../colors'

# Logical not (!) instruction.
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
      if thread.memory_wheel.pull == Instruction::LOGICAL_FALSE
        thread.memory_wheel.push Instruction::LOGICAL_TRUE
      else
        thread.memory_wheel.push Instruction::LOGICAL_FALSE
      end
    end
  end
end

# Logical and (&&) instruction, pushes stage_1 ^ stage_2.
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
      if (stage_1 != Instruction::LOGICAL_FALSE) && (stage_2 != Instruction::LOGICAL_FALSE)
        thread.memory_wheel.push Instruction::LOGICAL_TRUE
      else
        thread.memory_wheel.push Instruction::LOGICAL_FALSE
      end
    end
  end
end

# Logical or (||) instruction, pushes stage_1 || stage_2.
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
      if (stage_1 != Instruction::LOGICAL_FALSE) || (stage_2 != Instruction::LOGICAL_FALSE)
        thread.memory_wheel.push Instruction::LOGICAL_TRUE
      else
        thread.memory_wheel.push Instruction::LOGICAL_FALSE
      end
    end
  end
end

# Logical xor (^) instruction, pushes stage_1 ^ stage_2.
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
      if (stage_1 != Instruction::LOGICAL_FALSE) ^ (stage_2 != Instruction::LOGICAL_FALSE)
        thread.memory_wheel.push Instruction::LOGICAL_TRUE
      else
        thread.memory_wheel.push Instruction::LOGICAL_FALSE
      end
    end
  end
end