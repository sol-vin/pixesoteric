require_relative '../../instruction.rb'
require_relative '../../colors.rb'

# Moves the memory wheel to the right.
class MemWheelRight < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::BLACK, Colors::WHITE],
          [Colors::WHITE, Colors::WHITE, Colors::BLACK],
          [Colors::WHITE, Colors::BLACK, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      (color_value.to_i + 1).times { thread.memory_wheel.move_right }
    end
  end
end

# Moves the memory wheel to the left.
class MemWheelLeft < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::BLACK, Colors::WHITE],
          [Colors::BLACK, Colors::WHITE, Colors::WHITE],
          [Colors::WHITE, Colors::BLACK, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      (color_value.to_i + 1).times { thread.memory_wheel.move_left }
    end
  end
end

# Decrements the CMWL by the CV + 1.
class Decrement < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::WHITE, Colors::WHITE],
          [Colors::BLACK, Colors::WHITE, Colors::BLACK],
          [Colors::WHITE, Colors::BLACK, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      thread.memory_wheel.push(thread.memory_wheel.pull.to_i - (color_value.to_i + 1))
    end
  end
end

# Increments the CMWL by the CV + 1.
class Increment < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::BLACK, Colors::WHITE],
          [Colors::BLACK, Colors::WHITE, Colors::BLACK],
          [Colors::WHITE, Colors::WHITE, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      thread.memory_wheel.push(thread.memory_wheel.pull.to_i + (color_value.to_i + 1))
    end
  end
end

# Inserts the CV in the CMWL via push
class Insert < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::WHITE, Colors::WHITE],
          [Colors::BLACK, Colors::WHITE, Colors::WHITE],
          [Colors::BLACK, Colors::BLACK, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      thread.memory_wheel.push(color_value)
    end
  end
end

# Moves the color wheel to the location at CV.
class MovePosition < Instruction
  class << self
    def pattern
      [
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
          [Colors::WHITE, Colors::BLACK, Colors::WHITE],
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
      ]
    end

    def run(thread, color_value)
      thread.memory_wheel.jump color_value
    end
  end
end

# Pulls CMWL and pushes it to a location CV.
class InsertPosition < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::WHITE, Colors::BLACK],
          [Colors::BLACK, Colors::BLACK, Colors::WHITE],
          [Colors::BLACK, Colors::BLACK, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      thread.memory_wheel.memory[color_value] = thread.memory_wheel.pull.clone
    end
  end
end

# Pulls the value at location CV and pushes it to CMWL
class GetPosition < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::BLACK, Colors::BLACK],
          [Colors::WHITE, Colors::BLACK, Colors::BLACK],
          [Colors::BLACK, Colors::WHITE, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      thread.memory_wheel.push thread.memory_wheel.memory[color_value].to_i
    end
  end
end

# Push CMWL to static location CV.
class InsertStatic < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::BLACK, Colors::WHITE],
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
          [Colors::BLACK, Colors::BLACK, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      thread.parent.memory[color_value] = thread.memory_wheel.pull.to_i
    end
  end
end

# Pull static location CV and push to CMWL
class GetStatic < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::BLACK, Colors::BLACK],
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
          [Colors::WHITE, Colors::BLACK, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      thread.memory_wheel.push thread.parent.memory[color_value].to_i
    end
  end
end