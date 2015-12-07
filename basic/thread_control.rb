require_relative '../instruction.rb'
require_relative '../colors.rb'

class StartThreadRight < Instruction
  class << self
    def pattern
      [
          [Colors.BLACK, Colors.BLACK, Colors.BLACK],
          [Colors.BLACK, Colors.WHITE, Colors.WHITE],
          [Colors.BLACK, Colors.BLACK, Colors.BLACK],
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
          [Colors.BLACK, Colors.BLACK, Colors.BLACK],
          [Colors.WHITE, Colors.WHITE, Colors.BLACK],
          [Colors.BLACK, Colors.BLACK, Colors.BLACK],
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
          [Colors.BLACK, Colors.WHITE, Colors.BLACK],
          [Colors.BLACK, Colors.WHITE, Colors.BLACK],
          [Colors.BLACK, Colors.BLACK, Colors.BLACK],
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
          [Colors.BLACK, Colors.BLACK, Colors.BLACK],
          [Colors.BLACK, Colors.WHITE, Colors.BLACK],
          [Colors.BLACK, Colors.WHITE, Colors.BLACK],
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
          [Colors.BLACK, Colors.BLACK, Colors.BLACK],
          [Colors.BLACK, Colors.WHITE, Colors.BLACK],
          [Colors.BLACK, Colors.BLACK, Colors.BLACK],
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
          [Colors.WHITE, Colors.BLACK, Colors.WHITE],
          [Colors.BLACK, Colors.WHITE, Colors.BLACK],
          [Colors.WHITE, Colors.BLACK, Colors.WHITE],
      ]
    end

    def run(thread, color_value)
      thread.pause color_value.to_i
    end
  end
end

class PipeURD < Instruction
  class << self
    def pattern
      [
          [Colors.WHITE, Colors.BLACK, Colors.WHITE],
          [Colors.WHITE, Colors.BLACK, Colors.BLACK],
          [Colors.WHITE, Colors.BLACK, Colors.WHITE],
      ]
    end

    def run(thread, color_value)
      case (thread.direction)
        when :up
          thread.parent.fork_thread(thread, :right)
        when :left
          thread.turn_left
          thread.parent.fork_thread(thread, :up)
        when :down
          thread.parent.fork_thread(thread, :right)
        when :right
          thread.reverse
      end
    end
  end
end

class PipeLRD < Instruction
  class << self
    def pattern
      [
          [Colors.WHITE, Colors.WHITE, Colors.WHITE],
          [Colors.BLACK, Colors.BLACK, Colors.BLACK],
          [Colors.WHITE, Colors.BLACK, Colors.WHITE],
      ]
    end

    def run(thread, color_value)
      case (thread.direction)
        when :up
          thread.turn_left
          thread.parent.fork_thread(thread, :right)
        when :left
          thread.parent.fork_thread(thread, :down)
        when :down
          thread.reverse
        when :right
          thread.parent.fork_thread(thread, :down)
      end
    end
  end
end

class PipeULD < Instruction
  class << self
    def pattern
      [
          [Colors.WHITE, Colors.BLACK, Colors.WHITE],
          [Colors.BLACK, Colors.BLACK, Colors.WHITE],
          [Colors.WHITE, Colors.BLACK, Colors.WHITE],
      ]
    end

    def run(thread, color_value)
      case (thread.direction)
        when :up
          thread.parent.fork_thread(thread, :left)
        when :left
          thread.reverse
        when :down
          thread.parent.fork_thread(thread, :left)
        when :right
          thread.turn_left
          thread.parent.fork_thread(thread, :down)
      end
    end
  end
end

class PipeULR < Instruction
  class << self
    def pattern
      [
          [Colors.WHITE, Colors.BLACK, Colors.WHITE],
          [Colors.BLACK, Colors.BLACK, Colors.BLACK],
          [Colors.WHITE, Colors.WHITE, Colors.WHITE],
      ]
    end

    def run(thread, color_value)
      case (thread.direction)
        when :up
          thread.reverse
        when :left
          thread.parent.fork_thread(thread, :up)
        when :down
          thread.turn_left
          thread.parent.fork_thread(thread, :right)
        when :right
          thread.parent.fork_thread(thread, :up)
      end
    end
  end
end
