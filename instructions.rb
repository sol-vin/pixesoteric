require_relative 'basic/basic'


class Instructions
  class << self
    attr_reader :instructions
    @instructions = []

    def add_instruction(instruction)
      @instructions << instruction
    end

    def get_instruction(pattern)
      instructions.each do |i|
        if i.check_pattern(pattern)
          return i.new(i.get_color_value(pattern))
        end
      end
    end

    def run_instruction(thread, pattern)
      instruction = get_instruction(pattern)
      instruction.run(thread, instruction.class.get_color_value(pattern))
    end
  end

  attr_reader :array
  attr_reader :start_points

  START_POINTS = [StartThreadDown, StartThreadLeft, StartThreadRight, StartThreadUp]

  def initialize(image_file)
    image = ImageList.new(image_file)


    #ensure the file contains only 3x3 instructions
    throw ArgumentError.new unless (image.rows % Instruction::PATTERN_SIZE).zero? && (image.columns % Instruction::PATTERN_SIZE).zero?

    pattern_size = Instruction::PATTERN_SIZE

    #read through image_file and parse to a set of instructions
    instructions_x = image.columnns/pattern_size
    instructions_y = image.rows/pattern_size

    @array = Array.new(instructions_y, Array.new(instructions_x, nil))

    pattern_size = Instruction::PATTERN_SIZE


    #fill pattern
    image.columns.step(pattern_size) do |x|
      image.rows.step(pattern_size) do |y|
        @array[x/pattern_size][y/pattern_size] = Pattern.new
        pattern_sizetimes do |ox|
          pattern_size.times do |oy|
            @array[x/pattern_size][y/pattern_size][ox][oy] = img.pixel_color(x + ox, y + oy)
          end
        end
      end
    end

    #map to actual instructions
    @array.map! do |y_a|
      y_a.map! do |pattern|
        Instructions.get_instruction(pattern)
      end
    end

    @start_points = []
    point_struct = Struct.new(:p, :x, :y)
    @array.each_with_index do |y_a, y|
      y_a.each_with_index do |int, x|
        if START_POINTS.include?(item.class)
          @start_points << point_struct.new(int, x, y)
        end
      end
    end
  end
end