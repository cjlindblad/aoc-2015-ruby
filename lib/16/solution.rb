class MFCSAM
  def initialize
    ticker_sue_input = "children: 3, cats: 7, samoyeds: 2, pomeranians: 3, akitas: 0, vizslas: 0, goldfish: 5, trees: 3, cars: 2, perfumes: 1"
    @ticker_sue = Sue.from_string ticker_sue_input
    @sues = []
  end

  def add_sue input
    sue = Sue.from_string input
    @sues << sue
  end

  def find_matching_sue
    target_sue = 0
    @sues.each do |sue|
      if sue.compounds - @ticker_sue.compounds == []
        target_sue = sue.number
      end
    end
    target_sue
  end
end

class Sue
  attr_reader :number, :compounds

  def initialize number, compounds
    @number = number
    @compounds = compounds
  end

  def self.from_string string
    sue_string = string.match /^Sue (\d+): /
    sue_number = $1.to_i
    rest = string.sub(sue_string.to_s, '')
    compounds = []
    rest.split(',').each do |compound_string|
      name = compound_string.match /\w+/
      amount = compound_string.match /\d+/
      compound = Compound.new name.to_s, amount.to_s.to_i
      compounds.push compound
    end
    Sue.new sue_number, compounds
  end

  def to_s
    "Sue #{@number}: #{compounds}"
  end
end

class Compound
  attr_reader :name, :amount

  def initialize name, amount
    @name = name
    @amount = amount
  end

  def eql?(other)
    other.name == @name && other.amount == @amount
  end

  def hash
    @name.hash * @amount.hash
  end

  def to_s
    "#{@name}: #{@amount}"
  end
end

