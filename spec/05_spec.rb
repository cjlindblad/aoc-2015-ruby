require '05/solution'

RSpec.describe "Day 5 part 1" do
  it "thinks that ugknbfddgicrmopn is nice" do
    expect(StringCategorizer.nice? 'ugknbfddgicrmopn').to be true
  end
  
  it "thinks that aaa is nice" do
    expect(StringCategorizer.nice? 'aaa').to be true
  end

  it "thinks that jchzalrnumimnmhp is naughty" do
    expect(StringCategorizer.nice? 'jchzalrnumimnmhp').to be false
  end

  it "thinks that haegwjzuvuyypxyu is naughty" do
    expect(StringCategorizer.nice? 'haegwjzuvuyypxyu').to be false
  end

  it "thinks that dvszwmarrgswjxmb is naught" do
    expect(StringCategorizer.nice? 'dvszwmarrgswjxmb').to be false
  end

  it "solves part 1" do
    File.open('lib/05/input.txt') do |file|
      nice_strings = 0
      file.each_line do |line|
        nice_strings += 1 if StringCategorizer.nice? line
      end
      expect(nice_strings).to eq 236
    end
  end
end

RSpec.describe "Day 5 part 2" do
  it "thinks that qjhvhtzxzqqjkmpb is nice" do
    expect(StringCategorizer.really_nice? 'qjhvhtzxzqqjkmpb').to be true
  end

  it "thinks that xxyxx is nice" do
    expect(StringCategorizer.really_nice? 'xxyxx').to be true
  end

  it "thinks that uurcxstgmygtbstg is naughty" do
    expect(StringCategorizer.really_nice? 'uurcxstgmygtbstg').to be false
  end

  it "thinks that ieodomkazucvgmuy is naughty" do
    expect(StringCategorizer.really_nice? 'ieodomkazucvgmuy').to be false
  end

  it "solves part 2" do
    File.open('lib/05/input.txt') do |file|
      nice_strings = 0
      file.each_line do |line|
        nice_strings += 1 if StringCategorizer.really_nice? line
      end
      expect(nice_strings).to eq 51
    end
  end
end
