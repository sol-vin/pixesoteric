class MemoryWheel
  #memory array for the wheel
  attr_reader :memory
  #current position in memory
  attr_reader :memory_position


  def initialize
    @memory = []
    @memory_position = 0

    #set the first memory space
    push 0
  end

  def clone
    memory_wheel = MemoryWheel.new
    memory_wheel.instance_variable_set("@memory", memory.clone)
    memory_wheel.instance_variable_set("@memory_position", memory_position)
    memory_wheel
  end
 
  #moves the memory position to the right
  def move_right
    @memory_position += 1
    @memory << Color.new if @memory_position >= @memory.length
  end
  
  #moves the memory position to the left
  def move_left
    @memory_position -= 1
    if @memory_position < 0
      @memory_position = 0
      @memory.unshift Color.new
    end
  end

  #returns the value at the current memory location
  def pull
    @memory[memory_position]
  end
  
  #pushes a value into the current memory location.
  #Note: Rolls bytes over if too large / negative
  # -1 = 0xffffff, 0x1000000 = 0x0
  def push x
    @memory[memory_position] = Color.new(x.to_i)
  end

  def to_s
    dump = memory.inject([]) { |a, i| a << i.to_s }
    dump[memory_position] = "<(#{dump[memory_position]})>"
    dump.join(" ")
  end
end
