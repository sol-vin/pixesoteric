require_relative './boolean'
require_relative './comparison'
require_relative './conditionals'
require_relative './directions'
require_relative './math'
require_relative './memory'
require_relative './output'
require_relative './stage'
require_relative './thread_control'

require_relative '../../instruction'
require_relative '../../colors'

class Blank < Instruction
  class << self
    def pattern
      [
          [Colors::WHITE, Colors::WHITE, Colors::WHITE],
          [Colors::WHITE, Colors::WHITE, Colors::WHITE],
          [Colors::WHITE, Colors::WHITE, Colors::WHITE],
      ]
    end
  end
end