# Holds all the instructions and performs pattern checking on them.
# Instruction class subscribes itself to Instructions upon instancing.
# This is done at class level.
# Instances of Instructions are a set of instructions to run.
# Machine relies on this to run and match instructions.
class Instructions
  class << self
    # list of instructions that exist within the machine
    # uses this list to test if a read pattern in an instruction
    attr_reader :instructions

    def add_instruction(instruction)
      @instructions ||= []
      @instructions << instruction
    end

    # tests a pattern against all instructions until it finds a match
    def get_instruction(pattern)
      instructions.each do |i|
        # check the pattern to the instructions pattern
        if i.check_pattern(pattern)
          # return white if the instruction is blank since Blank
          # has no color value, if it's not blank get the color value
          # and make and store the instruction
          return ((i == Blank) ? i.new(0xffffff) : i.new(i.get_color_value(pattern).to_i))
        end
      end
      # the pattern was not recognized so we throw an error.
      fail :pattern_parse_error
    end

    # clears the instructions array
    def clear
      @instructions = []
    end

    # find and run an instruction on a thread.
    def run_instruction(thread, pattern)
      instruction = get_instruction(pattern)
      instruction.run(thread, instruction.class.get_color_value(pattern))
    end
  end

  # internal 2d array of read instructions
  attr_reader :array
  # list of the thread entry points
  attr_reader :start_points

  START_POINTS = [:StartThreadDown, :StartThreadLeft, :StartThreadRight, :StartThreadUp]

  def initialize(image_file)
    image = ImageList.new(File.absolute_path(image_file))


    # ensure the file contains only 3x3 instructions
    throw ArgumentError.new unless (image.rows % Instruction::PATTERN_SIZE).zero? and
        (image.columns % Instruction::PATTERN_SIZE).zero?

    pattern_size = Instruction::PATTERN_SIZE

    # read through image_file and parse to a set of instructions
    instructions_x = image.columns / pattern_size
    instructions_y = image.rows / pattern_size

    # create array
    @colors = Array.new(instructions_y)
    @colors.map! do
      Array.new(instructions_x).map do
        # each pattern
        Array.new(pattern_size).map do
          Array.new(pattern_size)
        end
      end
    end


    # fill patterns
    instructions_x.times do |x|
      instructions_y.times do |y|
        pattern_size.times do |ox|
          pattern_size.times do |oy|
            c = image.pixel_color((x * pattern_size) + ox,
                                  (y * pattern_size) + oy)
            color = Color.new
            color.r = c.red / 0x100
            color.g = c.green / 0x100
            color.b = c.blue / 0x100
            @colors[y][x][oy][ox] = color.clone
          end
        end
      end
    end


    # map to actual instructions
    @array = @colors.map do |y_a|
      y_a.map do |pattern|
        begin
          i = Instructions.get_instruction(pattern)
        rescue :pattern_parse_error # if the pattern was not found in the instructions
          puts("#{y_a.index(pattern)}, #{@colors.index(y_a)} had a nil instruction. Shutting down!")
          fail
        end
        i
      end
    end


    # find start points and list them so the machine can start program
    @start_points = []
    point_struct = Struct.new(:p, :x, :y)
    @array.each_with_index do |y_a, y|
      y_a.each_with_index do |int, x|
        if START_POINTS.include?(int.class.to_s.to_sym)
          @start_points << point_struct.new(int, x, y)
        end
      end
    end

    # sort the array by priority
    @start_points.sort! { |l, r| l.p.color_value.to_i <=> r.p.color_value.to_i }
  end

  # grab an instruction at the location x, y
  def get_instruction(x, y)
    @array[y][x]
  end
end
