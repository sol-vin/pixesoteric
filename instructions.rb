class Instructions
  class << self
    attr_reader :instructions


    def add_instruction(instruction)
      @instructions ||= []
      @instructions << instruction
    end

    def get_instruction(pattern)
      @instructions ||= []
      instructions.each do |i|
        if i.check_pattern(pattern)
          cv = i.get_color_value(pattern)
          puts "Got color_value: #{cv.r.to_s 16} from int #{i.class}"
          return i.new(cv.to_i)
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

  START_POINTS = [:StartThreadDown, :StartThreadLeft, :StartThreadRight, :StartThreadUp]

  def initialize(image_file)
    image = ImageList.new(image_file)


    #ensure the file contains only 3x3 instructions
    throw ArgumentError.new unless (image.rows % Instruction::PATTERN_SIZE).zero? && (image.columns % Instruction::PATTERN_SIZE).zero?

    pattern_size = Instruction::PATTERN_SIZE

    #read through image_file and parse to a set of instructions
    instructions_x = image.columns/pattern_size
    instructions_y = image.rows/pattern_size

    #create array
    @colors = Array.new(instructions_x)
    @colors.map! do |x_a|
      Array.new(instructions_y).map do |y_a|
        #each pattern
        Array.new(pattern_size).map do |x_p|
          Array.new(pattern_size)
        end
      end
    end


    #fill pattern
    instructions_x.times do |x|
      instructions_y.times do |y|
        pattern_size.times do |ox|
          pattern_size.times do |oy|
            c = image.pixel_color((x * pattern_size) + ox, (y * pattern_size) + oy)
            color = Color.new()
            color.r = c.red/0x100
            color.g = c.green/0x100
            color.b = c.blue/0x100
            @colors[x][y][oy][ox] = color.clone
          end
        end
      end
    end


    #map to actual instructions
    @array = @colors.map do |y_a|
      y_a.map do |pattern|
        Instructions.get_instruction(pattern)
      end
    end

    @start_points = []
    point_struct = Struct.new(:p, :x, :y)
    @array.each_with_index do |y_a, y|
      y_a.each_with_index do |int, x|
        if START_POINTS.include?(int.class.to_s.to_sym)
          puts "#{int} @ x: #{x} y: #{y}"
          @start_points << point_struct.new(int, x, y)
        end
      end
    end
  end

  def get_instruction(x, y)
    @array[x][y]
  end
end