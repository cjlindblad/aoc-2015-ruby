class Calculator
  def self.calculate_paper(instructions)
    sum = 0
    instructions.each do |instruction|
      values = self.parse instruction
      a = values[0] * values[1]
      b = values[1] * values[2]
      c = values[0] * values[2]
      list = [a, b, c].sort
      sum += (list.sum * 2) + list[0]
    end
    sum
  end

  def self.parse(instruction)
    instruction.split('x').map { |char| char.to_i }
  end
end

