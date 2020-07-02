class StringEvaluator
  attr_reader :code_length, :memory_length
  def initialize
    @code_length = 0
    @memory_length = 0
  end

  def add string
    @code_length += string.length
    @memory_length += eval(string).length
  end
end
