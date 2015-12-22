require_relative '../../instruction'
require_relative '../../colors'

# Adds stage_1 and stage_2 and pushes the result.
class Addition < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::BLACK, Colors::WHITE],
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
          [Colors::WHITE, Colors::BLACK, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      thread.memory_wheel.push(thread.stage_1.to_i + thread.stage_2.to_i)
    end
  end
end

# Subtracts stage_1 and stage_2 and pushes the result.
class Subtraction < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::WHITE, Colors::WHITE],
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
          [Colors::WHITE, Colors::WHITE, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      thread.memory_wheel.push(thread.stage_1.to_i - thread.stage_2.to_i)
    end
  end
end

# Multiplies stage_1 and stage_2 and pushes the result.
class Multiplication < Instruction
  class << self
    def pattern
      [
          [Colors::BLACK, Colors::WHITE, Colors::BLACK],
          [Colors::WHITE, Colors::BLACK, Colors::WHITE],
          [Colors::BLACK, Colors::WHITE, Colors::BLACK],
      ]
    end

    def run(thread, color_value)
      thread.memory_wheel.push(thread.stage_1.to_i * thread.stage_2.to_i)
    end
  end
end

# Divides stage_1 and stage_2 and pushes the result.
class Division < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::WHITE, Colors::BLACK],
          [Colors::WHITE, Colors::BLACK, Colors::WHITE],
          [Colors::BLACK, Colors::WHITE, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      thread.memory_wheel.push(thread.stage_1.to_i / thread.stage_2.to_i)
    end
  end
end

# Modulos(is that even a verb?) stage_1 and stage_2 and pushes the result.
class Modulo < Instruction
  class << self
    def pattern
      [
          [Colors::BLACK, Colors::BLACK, Colors::WHITE],
          [Colors::BLACK, Colors::WHITE, Colors::BLACK],
          [Colors::WHITE, Colors::BLACK, Colors::BLACK],
      ]
    end

    def run(thread, color_value)
      thread.memory_wheel.push(thread.stage_1.to_i % thread.stage_2.to_i)
    end
  end
end

