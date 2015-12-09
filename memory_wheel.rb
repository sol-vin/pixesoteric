class MemoryWheel

  attr_reader :memory
  attr_reader :memory_position

  MIN = 0
  MAX = 0xffffff

  def initialize
    @memory = []
    @memory_position = 0

    #set the first memory space
    push 0
  end

  def clone
    memory_wheel = MemoryWheel.new
    memory_wheel.instance_variable_set("@memory", memory)
    memory_wheel.instance_variable_set("@memory_position", memory_position)
  end

  def move_right
    @memory_position += 1
    @memory << Color.new if @memory_position >= @memory.length
  end

  def move_left
    @memory_position -= 1
    if @memory_position < 0
      @memory_position = 0
      @memory.unshift Color.new
    end
  end

  def pull
    @memory[memory_position]
  end

  def push x
    if x < 0
      x = (MAX - (x.abs % MAX) + 1)
    end
    x = x % MAX

    #roll the memory over
    @memory[memory_position] = Color.new(x)
  end
end