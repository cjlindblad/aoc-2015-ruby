require '08/solution'

describe StringEvaluator do
  it "solves part 1 example" do
    input = '""
    "abc"
    "aaa\"aaa"
    "\x27"'

    evaluator = StringEvaluator.new
    input.each_line { |line| evaluator.add(line.strip) }
    result = evaluator.code_length - evaluator.memory_length
    expect(result).to eq 12 
  end

  it "solves part 1" do
    evaluator = StringEvaluator.new
    File.open('lib/08/input.txt') do |file|
      file.each_line { |line| evaluator.add(line.strip) }
    end
    result = evaluator.code_length - evaluator.memory_length
    expect(result).to eq 1350
  end

  it "solves part 2 example" do
    input = '""
    "abc"
    "aaa\"aaa"
    "\x27"'

    original_chars = input.each_line.map { |line| line.strip.length }.sum
    encoded_chars = input.each_line.map { |line| StringEncoder.encode(line.strip).length }.sum
    expect(encoded_chars - original_chars).to eq 19
  end

  it "solves part 2" do
    File.open('lib/08/input.txt') do |file|
      input = file.each_line.map { |line| line.strip }
      original_chars = input.each.map { |line| line.length }.sum
      encoded_chars = input.each.map { |line| StringEncoder.encode(line).length }.sum
      expect(encoded_chars - original_chars).to eq 2085
    end
  end
end
