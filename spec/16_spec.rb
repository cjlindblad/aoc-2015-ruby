require '16/solution'

describe "day 16" do
  before :each do
    ticker_input = "children: 3, cats: 7, samoyeds: 2, pomeranians: 3, akitas: 0, vizslas: 0, goldfish: 5, trees: 3, cars: 2, perfumes: 1"
    @ticker_sue = Sue.from_string ticker_input
  end

  it "solves part 1" do
    sues = []
    File.open('lib/16/input.txt') do |file|
      file.each_line do |line|
        sue = Sue.from_string line
        sues << sue
      end
    end
    target_sue = 0
    sues.each do |sue|
      if sue.compounds - @ticker_sue.compounds == []
        target_sue = sue.number
      end
    end
    expect(target_sue).to eq 373
  end
end
