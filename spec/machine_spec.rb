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
end

