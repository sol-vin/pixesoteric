class Color
  #actual int value of the color (0xffffff is white)
  attr_accessor :value

  def initialize value = 0
    @value = value
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
    @value = (v << 16) + (g << 8) + b
  end

  def g= v
    @value = (r << 16) + (v << 8) + b
  end

  def b= v
    @value = (r << 16) + (g << 8) + v
  end

  def to_i
    value
  end

  def to_s
    "0x" << to_i.to_s(16)
  end

  def == other
    to_i == other.to_i
  end
end
