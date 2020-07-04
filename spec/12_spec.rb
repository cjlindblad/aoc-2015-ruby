require '12/solution'

describe DocumentAnalyzer do
  it "solves part 1" do
    input = File.read('lib/12/input.txt')
    document = DocumentAnalyzer.new input
    result = document.sum
    expect(result).to eq 119433
  end
end
