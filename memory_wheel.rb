class MemoryWheel

  attr_reader :memory
  attr_reader :memory_position

  def initialize
    @memory = [0]
    @memory_position = 0
  end

  def move_right
    @memory_position += 1
    @memory << 0 if @memory_position >= @memory.length
  end

  def move_left
    @memory_position -= 1
    if @memory_position < 0
      @memory_position = 0
      @memory.unshift 0
    end
  end

  def pull
    @memory[memory_position]
  end

  def push x
    if x < 0
      x = 0xffffff - (x.abs % 0xffffff)
    end
    x = x % 0xffffff

    #roll the memory over
    @memory[memory_position] = Color.new(x)
  end
end