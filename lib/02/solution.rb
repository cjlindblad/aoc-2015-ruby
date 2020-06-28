class Calculator
  def self.calculate_paper(instructions)
    sum = 0
    instructions.each do |instruction|
      box = Box.new(*self.parse(instruction))
      sum += box.paper_demand
    end
    sum
  end

  def self.parse(instruction)
    instruction.split('x').map { |char| char.to_i }
  end
end

class Box
  def initialize(width, depth, height)
    @width = width
    @depth = depth
    @height = height
  end

  def paper_demand
    side_a = @width * @depth
    side_b = @width * @height
    side_c = @depth * @height
    sorted_sides = [side_a, side_b, side_c].sort
    smallest_side = sorted_sides.first
    (sorted_sides.sum * 2) + smallest_side
  end
end
