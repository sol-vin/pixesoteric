require_relative '../../instruction'
require_relative '../../colors'

# Grabs a number from input until it hits a non-printable char or the end of input.
class GetInputNumber < Instruction
  class << self
    def pattern
      [
          [Colors::BLACK, Colors::BLACK, Colors::WHITE],
          [Colors::BLACK, Colors::WHITE, Colors::WHITE],
          [Colors::WHITE, Colors::WHITE, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      thread.memory_wheel.push thread.parent.get_input_number
    end
  end
end

# Gets a single char from input.
class GetInputChar < Instruction
  class << self
    def pattern
      [
          [Colors::BLACK, Colors::BLACK, Colors::WHITE],
          [Colors::BLACK, Colors::WHITE, Colors::WHITE],
          [Colors::WHITE, Colors::WHITE, Colors::BLACK],
      ]
    end

    def run(thread, color_value)
      thread.memory_wheel.push thread.parent.get_input_char
    end
  end
end