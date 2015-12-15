require 'rspec'
require_relative '../machine'


describe 'Machine Tests' do
  it 'should run a_to_z' do
    a_to_z = Machine.new('programs/a_to_z.bmp')
    a_to_z.run
    expect(a_to_z.output).to eq ('A'..'Z').to_a.join
  end

  it 'should run factorial' do
    factorial = Machine.new('programs/factorial.bmp')
    factorial.run
    expect(factorial.output).to eq '3628800'
  end
end