require_relative '../../instruction'
require_relative '../../colors'


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
      thread.stage_1 = thread.memory_wheel.pull
    end
  end
end

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
      thread.stage_2 = thread.memory_wheel.pull
    end
  end
end

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
      thread.stage_1 = mem
      thread.memory_wheel.push s_1
    end
  end
end

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

class ShiftPush < Instruction
  class << self
    def pattern
      [
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
          [Colors::WHITE, Colors::WHITE, Colors::WHITE],
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
      ]
    end

    def run(thread, color_value)
      thread.stage_2 = thread.stage_1
      thread.stage_1 = thread.memory_wheel.pull
    end
  end
end

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
      thread.memory_wheel.move_left
    end
  end
end

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
      thread.memory_wheel.move_right
    end
  end
end








