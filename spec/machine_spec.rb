require 'rspec'
require_relative '../machine'


describe 'Machine Tests' do
  it 'should run hello_world' do
    hello_world = Machine.new('programs/hello_world.bmp')
    hello_world.run
    expect(hello_world.output).to eq "Hello, world!"
  end

  it 'should run hello_world_multiplex' do
    hello_world = Machine.new('programs/hello_world_multiplex.bmp')
    hello_world.run
    expect(hello_world.output).to eq "Hello, world!"
  end

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

  it 'should run factors' do
    factors = Machine.new('programs/factors.bmp')
    factors.run
    expect(factors.output).to eq "2 4 5 8 10 20 25 40 50 100 125 200 250 500 "
  end

  it 'should run fibonacci' do
    fibonacci = Machine.new('programs/fibonacci.bmp')
    fibonacci.run
    expect(fibonacci.output).to eq '1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597 2584 4181 6765 10946 17711 28657 46368 75025 121393 196418 317811 514229 832040 1346269 2178309 3524578'
  end

  it 'should run project_euler_1' do
    project_euler_1 = Machine.new('programs/project_euler_1.bmp')
    project_euler_1.run
    expect(project_euler_1.output).to eq "233168"
  end

  it 'should run project_euler_2' do
    project_euler_2 = Machine.new('programs/project_euler_2.bmp')
    project_euler_2.run
    expect(project_euler_2.output).to eq "4613732"
  end

  it 'should run pipe_test_1' do
    pipe_test_1 = Machine.new('programs/pipe_test_1.bmp')
    pipe_test_1.run
    expect(pipe_test_1.output).to eq "1234"
  end

  it 'should run pipe_test_2' do
    pipe_test_2 = Machine.new('programs/pipe_test_2.bmp')
    pipe_test_2.run
    expect(pipe_test_2.output).to eq "12345678"
  end

  it 'should run thread_pause' do
    thread_pause = Machine.new('programs/thread_pause.bmp')
    thread_pause.run
    expect(thread_pause.output).to eq "HELLOHELLO"
  end

  it 'should run thread_priority' do
    thread_priority = Machine.new('programs/thread_priority.bmp')
    thread_priority.run
    expect(thread_priority.output).to eq "012345678"
  end
end

