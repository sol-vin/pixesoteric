require_relative '../../instruction'
require_relative '../../colors'

# Pushes CMWL to stage_1.
class Stage1 < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::WHITE, Colors::BLACK],
          [Colors::WHITE, Colors::WHITE, Colors::BLACK],
          [Colors::WHITE, Colors::WHITE, Colors::BLACK],
      ]
    end

    def run(thread, color_value)
      mem = thread.memory_wheel.pull.to_i
      if color_value.to_i != 0x000000
        mem &= color_value.to_i
      end
      thread.stage_1 = Color.new(mem)
    end
  end
end

# Pushes CMWL to stage_2.
class Stage2 < Instruction
  class << self
    def pattern
      [
          [Colors::BLACK, Colors::WHITE, Colors::BLACK],
          [Colors::BLACK, Colors::WHITE, Colors::BLACK],
          [Colors::BLACK, Colors::WHITE, Colors::BLACK],
      ]
    end

    def run(thread, color_value)
      mem = thread.memory_wheel.pull.to_i
      if color_value.to_i != 0x000000
        mem &= color_value.to_i
      end
      thread.stage_2 = Color.new(mem)
    end
  end
end

# Pushes CV to stage_1.
class Stage1Color < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::WHITE, Colors::BLACK],
          [Colors::BLACK, Colors::WHITE, Colors::BLACK],
          [Colors::WHITE, Colors::WHITE, Colors::BLACK],
      ]
    end

    def run(thread, color_value)
      thread.stage_1 = color_value
    end
  end
end

# Pushes CV to stage_2.
class Stage2Color < Instruction
  class << self
    def pattern
      [
          [Colors::BLACK, Colors::WHITE, Colors::BLACK],
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
          [Colors::BLACK, Colors::WHITE, Colors::BLACK],
      ]
    end

    def run(thread, color_value)
      thread.stage_2 = color_value
    end
  end
end

# Swaps CMWL and stage_1.
class SwapMemStage < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::BLACK, Colors::WHITE],
          [Colors::WHITE, Colors::WHITE, Colors::WHITE],
          [Colors::WHITE, Colors::BLACK, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      s_1 = thread.stage_1
      mem = thread.memory_wheel.pull
      thread.stage_1 = mem.to_i
      thread.memory_wheel.push s_1.to_i
    end
  end
end

# Swaps stage_1 and stage_2
class SwapStages < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::WHITE, Colors::WHITE],
          [Colors::BLACK, Colors::WHITE, Colors::BLACK],
          [Colors::WHITE, Colors::WHITE, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      s_1 = thread.stage_1
      s_2 = thread.stage_2
      thread.stage_1 = s_2
      thread.stage_2 = s_1
    end
  end
end

# Pushes stage_1 to stage_2 amd pushes CMWL to stage_1
class ShiftPush < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::BLACK, Colors::WHITE],
          [Colors::BLACK, Colors::WHITE, Colors::BLACK],
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
      ]
    end

    def run(thread, color_value)
      thread.stage_2 = thread.stage_1
      thread.stage_1 = thread.memory_wheel.pull
    end
  end
end
# Pushes stage_1 to stage_2 amd pushes CMWL to stage_1, then moves to the left CV times.
class ShiftStageLeft < Instruction
  class << self
    def pattern
      [
          [Colors::BLACK, Colors::BLACK, Colors::WHITE],
          [Colors::BLACK, Colors::WHITE, Colors::WHITE],
          [Colors::BLACK, Colors::BLACK, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      thread.stage_2 = thread.stage_1
      thread.stage_1 = thread.memory_wheel.pull
      (color_value+1).times { thread.memory_wheel.move_left }
    end
  end
end

# Pushes stage_1 to stage_2 amd pushes CMWL to stage_1, then moves to the right CV times.
class ShiftStageRight < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::BLACK, Colors::BLACK],
          [Colors::WHITE, Colors::WHITE, Colors::BLACK],
          [Colors::WHITE, Colors::BLACK, Colors::BLACK],
      ]
    end

    def run(thread, color_value)
      thread.stage_2 = thread.stage_1
      thread.stage_1 = thread.memory_wheel.pull
      (color_value+1).times { thread.memory_wheel.move_right }
    end
  end
end

# Pushes stage_1 to CMWL masked by CV.
class Stage1Push < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::BLACK, Colors::BLACK],
          [Colors::WHITE, Colors::BLACK, Colors::BLACK],
          [Colors::WHITE, Colors::WHITE, Colors::BLACK],
      ]
    end

    def run(thread, color_value)
      mem = thread.stage_1.to_i
      if color_value.to_i != 0x000000
        mem &= color_value.to_i
      end
      thread.memory_wheel.push mem
    end
  end
end

# Pushes stage_2 to CMWL masked by CV.
class Stage2Push < Instruction
  class << self
    def pattern
      [
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
          [Colors::BLACK, Colors::WHITE, Colors::BLACK],
      ]
    end

    def run(thread, color_value)
      mem = thread.stage_2.to_i
      if color_value.to_i != 0x000000
        mem &= color_value.to_i
      end
      thread.memory_wheel.push mem
    end
  end
end








