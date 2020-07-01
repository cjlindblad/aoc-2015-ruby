require '07/solution'

describe Gate do
  it "parses 'ab LSHIFT 2 -> c'" do
    gate = Gate.new "ab LSHIFT 2 -> c"
    expect(gate.op).to be :LSHIFT
    expect(gate.lhs).to be :ab
    expect(gate.rhs).to be 2
    expect(gate.dest).to be :c
    expect(gate.inverse).to be false
  end

  it "parses 'NOT 1337 -> abc'" do
    gate = Gate.new "NOT 1337 -> abc"
    expect(gate.op).to eq nil
    expect(gate.lhs).to be 1337
    expect(gate.rhs).to be nil
    expect(gate.dest).to be :abc
    expect(gate.inverse).to be true
  end
end

describe Circuit do
  it "parses example instructions for part 1" do
    input = "123 -> x
    456 -> y
    x AND y -> d
    x OR y -> e
    x LSHIFT 2 -> f
    y RSHIFT 2 -> g
    NOT x -> h
    NOT y -> i"
    circuit = Circuit.new
    input.each_line { |line| circuit.add(Gate.new(line.strip)) }
    values = circuit.execute
    expected_values = {
      d: 72,
      e: 507,
      f: 492,
      g: 114,
      h: 65412,
      i: 65079,
      x: 123,
      y: 456,
    }
    expect(values).to eq expected_values
  end

  it "solves part 1" do
    circuit = Circuit.new
    File.open('lib/07/input.txt') do |file|
      file.each_line { |line| circuit.add(Gate.new line) }
    end
    value = circuit.execute_single(:a)
    expect(value).to be 46065
  end
end
