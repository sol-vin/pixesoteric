require_relative '../../instruction'
require_relative '../../colors'

#Outputs the CMWL as a char using r + g + b
class OutputMemChar < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::BLACK, Colors::BLACK],
          [Colors::WHITE, Colors::WHITE, Colors::BLACK],
          [Colors::BLACK, Colors::WHITE, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      mem = thread.memory_wheel.pull.to_i

      if color_value.to_i != 0x000000
        mem &= color_value.to_i
      end
      char = ((mem & 0xff0000) >> 16) + ((mem & 0xff00) >> 8) + (mem & 0xff)
      thread.parent.write_output char.chr
    end
  end
end

#Outputs the CMWL as a number. CV masks the value.
class OutputMemInt < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::BLACK, Colors::BLACK],
          [Colors::WHITE, Colors::WHITE, Colors::BLACK],
          [Colors::WHITE, Colors::WHITE, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      mem = thread.memory_wheel.pull.to_i

      if color_value.to_i != 0x000000
        mem &= color_value.to_i
      end

      thread.parent.write_output mem.to_s
    end
  end
end

# Ouputs the CMWL as hex. CV masks the value.
class OutputMemHex < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::BLACK, Colors::BLACK],
          [Colors::BLACK, Colors::WHITE, Colors::BLACK],
          [Colors::WHITE, Colors::BLACK, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      mem = thread.memory_wheel.pull.to_i

      if color_value.to_i != 0x000000
        mem &= color_value.to_i
      end

      thread.parent.write_output(mem.to_s(16))
    end
  end
end

# Outputs CV as a char, using r + g + b
class OutputColorChar < Instruction
  class << self
    def pattern
      [
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
          [Colors::WHITE, Colors::WHITE, Colors::BLACK],
          [Colors::BLACK, Colors::WHITE, Colors::BLACK],
      ]
    end

    def run(thread, color_value)
      mem = color_value.to_i
      char = (((mem & 0xff0000) >> 16) + ((mem & 0xff00) >> 8) + (mem & 0xff)) % 0x100
      thread.parent.write_output char.chr
    end
  end
end

# Output the CV as a number.
class OutputColorNumber < Instruction
  class << self
    def pattern
      [
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
          [Colors::WHITE, Colors::WHITE, Colors::BLACK],
          [Colors::WHITE, Colors::WHITE, Colors::BLACK],
      ]
    end

    def run(thread, color_value)
      thread.parent.write_output(color_value.to_i.to_s)
    end
  end
end

# Output the CV as hex.
class OutputColorHex < Instruction
  class << self
    def pattern
      [
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
          [Colors::BLACK, Colors::WHITE, Colors::BLACK],
          [Colors::WHITE, Colors::BLACK, Colors::BLACK],
      ]
    end

    def run(thread, color_value)
      thread.parent.write_output(color_value.to_i.to_s(16))
    end
  end
end

# Pushes CV and outputs CV as a number
class InputAndOutputNumber < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::BLACK, Colors::BLACK],
          [Colors::BLACK, Colors::WHITE, Colors::BLACK],
          [Colors::BLACK, Colors::BLACK, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      thread.parent.write_output(color_value.to_i.to_s)
      thread.memory_wheel.push color_value.to_i
    end
  end
end

# Pushes CV and outputs CV as a char using r + g + b.
class InputAndOutputChar < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::BLACK, Colors::BLACK],
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
          [Colors::BLACK, Colors::BLACK, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      thread.parent.write_output(color_value.to_i.to_s)
      thread.memory_wheel.push color_value.to_i
    end
  end
end