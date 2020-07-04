class DocumentAnalyzer
  def initialize string
    @string = string
  end

  def sum
    digits = @string.scan /-?\d+/
    print digits
    digits.reduce(0) { |a, c| a + c.to_i }
  end
end
