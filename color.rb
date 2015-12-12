class Color
  #min byte
  MIN = 0
  #max byte
  MAX = 0x1000000

  #actual int value of the color (0xffffff is white)
  attr_reader :value

  def initialize v = 0
    if v < 0
      v = ((MAX-1) - (v.abs % MAX) + 1)
    end
    v = v % MAX
    @value = v
  end

  def value= x
    if x < 0
      x = (MAX - (x.abs % MAX) + 1)
    end
    x = x % MAX
    @value = x
  end

  def r
    (value & 0xff0000) >> 16
  end

  def g
    (value & 0x00ff00) >> 8
  end

  def b
    (value & 0x0000ff)
  end

  def r= v
    v = v % 0x1000
    @value = (v << 16) + (g << 8) + b
  end

  def g= v
    v = v % 0x1000
    @value = (r << 16) + (v << 8) + b
  end

  def b= v
    v = v % 0x1000
    @value = (r << 16) + (g << 8) + v
  end

  def to_i
    value
  end

  def to_s
    "0x" << to_i.to_s(16)
  end

  def to_24_bit

  end

  def == other
    to_i == other.to_i
  end
end
