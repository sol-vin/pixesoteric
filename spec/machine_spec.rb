require 'rspec'
require_relative '../machine'


describe 'Machine Tests' do
  #easy tests
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

  it 'should run factorial 3' do
    factorial = Machine.new('programs/factorial.bmp', '3')
    factorial.run
    expect(factorial.output).to eq '6'
  end

  it 'should run factorial 4' do
    factorial = Machine.new('programs/factorial.bmp', '4')
    factorial.run
    expect(factorial.output).to eq '24'
  end

  it 'should run factorial 10' do
    factorial = Machine.new('programs/factorial.bmp', '10')
    factorial.run
    expect(factorial.output).to eq '3628800'
  end

  it 'should run fibonacci 10' do
    fibonacci = Machine.new('programs/fibonacci.bmp', '10')
    fibonacci.run
    expect(fibonacci.output).to eq '1 1 2 3 5 8 13 21 34 55 89 144'
  end

  it 'should run fibonacci 31' do
    fibonacci = Machine.new('programs/fibonacci.bmp', '31')
    fibonacci.run
    expect(fibonacci.output).to eq '1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597 2584 4181 6765 10946 17711 28657 46368 75025 121393 196418 317811 514229 832040 1346269 2178309 3524578'
  end

  it 'should run odd_or_even 2323' do
    odd_or_even = Machine.new('programs/odd_or_even.bmp', '2323')
    odd_or_even.run
    expect(odd_or_even.output).to eq "ODD"
  end

  it 'should run odd_or_even 2424' do
    odd_or_even = Machine.new('programs/odd_or_even.bmp', '2424')
    odd_or_even.run
    expect(odd_or_even.output).to eq "EVEN"
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

  it 'should run insert_static_test' do
    insert_static_test = Machine.new('programs/insert_static_test.bmp')
    insert_static_test.run
    expect(insert_static_test.output).to eq "65280"
  end

  it 'should run is_palindrome 101' do
    is_palindrome = Machine.new('programs/is_palindrome.bmp', "101")
    is_palindrome.run
    expect(is_palindrome.output).to eq "TRUE"
  end

  it 'should run is_palindrome 1234321' do
    is_palindrome = Machine.new('programs/is_palindrome.bmp', "1234321")
    is_palindrome.run
    expect(is_palindrome.output).to eq "TRUE"
  end

  it 'should run is_palindrome 1234' do
    is_palindrome = Machine.new('programs/is_palindrome.bmp', "1234")
    is_palindrome.run
    expect(is_palindrome.output).to eq "FALSE"
  end

  it 'should run is_palindrome 113456' do
    is_palindrome = Machine.new('programs/is_palindrome.bmp', "113456")
    is_palindrome.run
    expect(is_palindrome.output).to eq "FALSE"
  end

  it 'should run is_prime 7298' do
    insert_static_test = Machine.new('programs/is_prime.bmp', '7298')
    insert_static_test.run
    expect(insert_static_test.output).to eq "7298 NOT PRIME"
  end

  it 'should run is_prime 9999' do
    insert_static_test = Machine.new('programs/is_prime.bmp', '9999')
    insert_static_test.run
    expect(insert_static_test.output).to eq "9999 NOT PRIME"
  end

  #hard tests
  it 'should run factors 500' do
    factors = Machine.new('programs/factors.bmp', '500')
    factors.run
    expect(factors.output).to eq "2 4 5 10 20 25 50 100 125 250"
  end


  it 'should run factors 1000' do
    factors = Machine.new('programs/factors.bmp', '1000')
    factors.run
    expect(factors.output).to eq "2 4 5 8 10 20 25 40 50 100 125 200 250 500"
  end

  it 'should run factors 2700' do
    factors = Machine.new('programs/factors.bmp', '2700')
    factors.run
    expect(factors.output).to eq "2 3 4 5 6 9 10 12 15 18 20 25 27 30 36 45 50 54 60 75 90 100 108 135 150 180 225 270 300 450 540 675 900 1350"
  end

  it 'should run is_prime 7297' do
    insert_static_test = Machine.new('programs/is_prime.bmp', '7297')
    insert_static_test.run
    expect(insert_static_test.output).to eq "7297 PRIME"
  end

  #project_euler solutions
  it 'should run project_euler_1 1000' do
    project_euler_1 = Machine.new('programs/project_euler_1.bmp', '1000')
    project_euler_1.run
    expect(project_euler_1.output).to eq "233168"
  end

  it 'should run project_euler_2 34' do
    project_euler_2 = Machine.new('programs/project_euler_2.bmp', '34')
    project_euler_2.run
    expect(project_euler_2.output).to eq "4613732"
  end

  it 'should run project_euler_3 14' do
    project_euler_3 = Machine.new('programs/project_euler_3.bmp', '14')
    project_euler_3.run
    expect(project_euler_3.output).to eq "7"
  end

  it 'should run project_euler_3 13195' do
    project_euler_3 = Machine.new('programs/project_euler_3.bmp', '13195')
    project_euler_3.run
    expect(project_euler_3.output).to eq "29"
  end

  it 'should run project_euler_4 99' do
    project_euler_4 = Machine.new('programs/project_euler_4.bmp', '99')
    project_euler_4.run
    expect(project_euler_4.output).to eq "9009"
  end

  it 'should run project_euler_4 999' do
    project_euler_4 = Machine.new('programs/project_euler_4.bmp', '999')
    project_euler_4.log.level = Logger::WARN
    project_euler_4.run
    expect(project_euler_4.output).to eq "906609"
  end

  it 'should run project_euler_5 10' do
    project_euler_5 = Machine.new('programs/project_euler_5.bmp', '10')
    project_euler_5.run
    expect(project_euler_5.output).to eq "2520"
  end
end

