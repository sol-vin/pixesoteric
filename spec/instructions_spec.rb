require 'rspec'
require_relative '../machine'


describe 'Instructions Tests' do
  it 'should read the correct start points from images' do
    a_to_z = Machine.new('programs/a_to_z.bmp')
    expect(a_to_z.instructions.start_points.length).to eq 1
    expect(a_to_z.instructions.start_points.first.p.class).to eq StartThreadRight
    expect(a_to_z.instructions.start_points.first.x).to eq 0
    expect(a_to_z.instructions.start_points.first.y).to eq 1

    factorial = Machine.new('programs/factorial.bmp')
    expect(factorial.instructions.start_points.length).to eq 1
    expect(factorial.instructions.start_points.first.p.class).to eq StartThreadLeft
    expect(factorial.instructions.start_points.first.x).to eq 3
    expect(factorial.instructions.start_points.first.y).to eq 0

    fibonacci = Machine.new('programs/fibonacci.bmp')
    expect(fibonacci.instructions.start_points.length).to eq 1
    expect(fibonacci.instructions.start_points.first.p.class).to eq StartThreadLeft
    expect(fibonacci.instructions.start_points.first.x).to eq 9
    expect(fibonacci.instructions.start_points.first.y).to eq 0

    thread_priority = Machine.new('programs/thread_priority.bmp')
    expect(thread_priority.instructions.start_points.length).to eq 9
  end
  
end