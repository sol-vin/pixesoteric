require_relative '../../instruction'
require_relative '../../colors'

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
      char = ((mem & 0xff0000) >> 16) + ((mem & 0xff00) >> 8) + (mem & 0xff)
      thread.parent.write_output char.chr
    end
  end
end

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
      thread.parent.write_output(color_value.to_i)
    end
  end
end


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


