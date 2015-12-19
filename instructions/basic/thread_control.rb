require_relative '../../instruction.rb'
require_relative '../../colors.rb'

class StartThreadRight < Instruction
  class << self
    def pattern
      [
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
          [Colors::BLACK, Colors::WHITE, Colors::WHITE],
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
      ]
    end

    def direction
      :right
    end

    def run(thread, color_value)
      thread.change_direction :right
    end
  end
end


class StartThreadLeft < Instruction
  class << self
    def pattern
      [
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
          [Colors::WHITE, Colors::WHITE, Colors::BLACK],
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
      ]
    end

    def direction
      :left
    end

    def run(thread, color_value)
      thread.change_direction :left
    end
  end
end

class StartThreadUp < Instruction
  class << self
    def pattern
      [
          [Colors::BLACK, Colors::WHITE, Colors::BLACK],
          [Colors::BLACK, Colors::WHITE, Colors::BLACK],
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
      ]
    end

    def direction
      :up
    end

    def run(thread, color_value)
      thread.change_direction :up
    end
  end
end


class StartThreadDown < Instruction
  class << self
    def pattern
      [
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
          [Colors::BLACK, Colors::WHITE, Colors::BLACK],
          [Colors::BLACK, Colors::WHITE, Colors::BLACK],
      ]
    end

    def direction
      :down
    end

    def run(thread, color_value)
      thread.change_direction :down
    end
  end
end

class EndThread < Instruction
  class << self
    def pattern
      [
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
          [Colors::BLACK, Colors::WHITE, Colors::BLACK],
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
      ]
    end

    def run(thread, color_value)
      thread.kill
    end
  end
end


class PauseThread < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::BLACK, Colors::WHITE],
          [Colors::BLACK, Colors::WHITE, Colors::BLACK],
          [Colors::WHITE, Colors::BLACK, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      thread.pause color_value.to_i + 1
    end
  end
end

class ForkPipeURD < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::BLACK, Colors::WHITE],
          [Colors::WHITE, Colors::BLACK, Colors::BLACK],
          [Colors::WHITE, Colors::BLACK, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      case (thread.direction)
        when :up
          thread.parent.fork_thread(thread, :right)
        when :left
          thread.parent.fork_thread(thread, :left)
          thread.turn_right
        when :down
          thread.parent.fork_thread(thread, :left)
        when :right
          thread.reverse
      end
    end
  end
end

class ForkPipeLRD < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::WHITE, Colors::WHITE],
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
          [Colors::WHITE, Colors::BLACK, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      case (thread.direction)
        when :up
          thread.parent.fork_thread(thread, :left)
          thread.turn_right
        when :left
          thread.parent.fork_thread(thread, :left)
        when :down
          thread.reverse
        when :right
          thread.parent.fork_thread(thread, :right)
      end
    end
  end
end

class ForkPipeULD < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::BLACK, Colors::WHITE],
          [Colors::BLACK, Colors::BLACK, Colors::WHITE],
          [Colors::WHITE, Colors::BLACK, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      case (thread.direction)
        when :up
          thread.parent.fork_thread(thread, :left)
        when :left
          thread.reverse
        when :down
          thread.parent.fork_thread(thread, :right)
        when :right
          thread.parent.fork_thread(thread, :left)
          thread.turn_right
      end
    end
  end
end

class ForkPipeULR < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::BLACK, Colors::WHITE],
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
          [Colors::WHITE, Colors::WHITE, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      case (thread.direction)
        when :up
          thread.reverse
        when :left
          thread.parent.fork_thread(thread, :right)
        when :down
          thread.parent.fork_thread(thread, :left)
          thread.turn_right
        when :right
          thread.parent.fork_thread(thread, :left)
      end
    end
  end
end

class Jump < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::WHITE, Colors::WHITE],
          [Colors::WHITE, Colors::BLACK, Colors::WHITE],
          [Colors::WHITE, Colors::WHITE, Colors::WHITE],
      ]
    end

    def run(thread, color_value)
      thread.move color_value.to_i + 1
    end
  end
end

class Call < Instruction
  class << self
    def pattern
      [
          [Colors::BLACK, Colors::BLACK, Colors::WHITE],
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
          [Colors::WHITE, Colors::BLACK, Colors::BLACK],
      ]
    end

    def run(thread, color_value)
      x = ((color_value & 0xfff000) >> 12) - 0x7ff
      y = (color_value & 0xfff) - 0x7ff
      thread.jump(x, y)
    end
  end
end
