require './colors'
require './instruction'

class Pattern < Array
  def initalize
    super(Instruction::PATTERN_SIZE, Array.new(Instruction::PATTERN_SIZE, Colors.WHITE))
  end
end