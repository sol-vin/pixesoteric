require_relative '../../instruction.rb'
require_relative '../../colors.rb'

# Starts a thread heading right.
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

# Starts a thread heading left.
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

# Starts a thread heading up.
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

# Starts a thread heading down.
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

# Ends a thread.
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

# Pauses a thread for CV cycles.
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

# Forks a thread and changes it's direction based on the direction it came in and forks the thread a new direction.
# Just look at the symbol, you'll figure it out, the non-pipe side reverses the threads direction.
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
        else
          raise Exception.new
      end
    end
  end
end

# Forks a thread and changes it's direction based on the direction it came in and forks the thread a new direction.
# Just look at the symbol, you'll figure it out, the non-pipe side reverses the threads direction.
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
        else
          raise Exception.new
      end
    end
  end
end

# Forks a thread and changes it's direction based on the direction it came in and forks the thread a new direction.
# Just look at the symbol, you'll figure it out, the non-pipe side reverses the threads direction.
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
        else
          raise Exception.new
      end
    end
  end
end

# Forks a thread and changes it's direction based on the direction it came in and forks the thread a new direction.
# Just look at the symbol, you'll figure it out, the non-pipe side reverses the threads direction.
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
        else
          raise Exception.new
      end
    end
  end
end

# Jumps a thread a CV+1 instructions.
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

# Moves the thread 0xXXXYYY spaces where x:0 y:0 = 0x7FF7FF
# Examples: x: -1, y: 1 0x7FE800  x: 1, y: -1 0x8007FE
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

# Clears the threads memory.
class Refresh < Instruction
  class << self
    def pattern
      [
          [Colors::BLACK, Colors::BLACK, Colors::BLACK],
          [Colors::WHITE, Colors::BLACK, Colors::WHITE],
          [Colors::BLACK, Colors::WHITE, Colors::BLACK],
      ]
    end

    def run(thread, color_value)
      thread.reset
    end
  end
end
