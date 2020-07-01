class Integer
  def to_16_bit_unsigned
    (self + 65536) % 65536
  end
end

class Circuit
  def initialize
    @wires = {}
  end

  def add gate
    expression_lambda = get_expression_lambda gate
    @wires[gate.dest] = expression_lambda
  end

  def get_expression_lambda gate
    if gate.op.nil?
      if gate.inverse
        return lambda { (~(parse_operand(gate.lhs))).to_16_bit_unsigned }
      else
        return lambda { parse_operand(gate.lhs) }
      end
    end

    unless gate.op.nil?
      return lambda { call_operator(gate.op, parse_operand(gate.lhs), parse_operand(gate.rhs)) } 
    end
  end

  def call_operator op, lhs, rhs
    case op
    when :AND then lhs & rhs
    when :OR then lhs | rhs
    when :LSHIFT then lhs << rhs
    when :RSHIFT then lhs >> rhs
    else raise Error("Unknown op #{op}")
    end
  end

  def parse_operand operand
    if operand.is_a? Integer
      operand
    else
      result = @wires[operand].call
      if result.is_a? Integer
        @wires[operand] = lambda { result }
      end
      result
    end
  end

  def execute
    @wires.map { |k, v| [k, v.call] }.to_h
  end

  def execute_single name
    @wires[name].call
  end
end

class Gate
  attr_reader :op, :lhs, :rhs, :dest, :inverse
  def initialize instruction
    instruction.match(/(NOT)?\s?([a-z\d]+)\s?(AND|OR|LSHIFT|RSHIFT)?\s?([a-z\d]+)? -> ([a-z]+)/)
    @inverse = !!($1)
    @lhs = parse_operand $2
    @op = ($3).to_sym unless ($3).nil?
    @rhs = parse_operand $4
    @dest = $5.to_sym
  end

  def parse_operand operand
    if operand.nil?
      return nil
    elsif operand =~ /^\d+$/
      return operand.to_i
    else return operand.to_sym
    end
  end

  def to_s
    result = ""
    result += "NOT " if @inverse
    result += "#{@lhs} "
    result += "#{@op} " if @op
    result += "#{@rhs} " if @rhs
    result += "-> #{@dest}"
  end
end
