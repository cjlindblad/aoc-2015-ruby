require '02/solution'

RSpec.describe 'day 2 part 1 solution' do
  it 'needs 58 square feet from 2x3x4 box' do
    result = Calculator.calculate_paper(['2x3x4'])
    expect(result).to eq 58
  end

  it 'needs 43 square feet from 1x1x10 box' do
    result = Calculator.calculate_paper(['1x1x10'])
    expect(result).to eq 43
  end

  it 'solves part 1' do
    File.open('lib/02/input.txt') do |file|
      input = file.read
      result = Calculator.calculate_paper(input.split("\n"))
      expect(result).to eq 1588178
    end
  end
end

RSpec.describe 'day 2 part 2 solution' do
  it 'needs 34 feet of ribbon for 2x3x4 box' do
    result = Calculator.calculate_ribbon(['2x3x4'])
    expect(result).to eq 34
  end

  it 'needs 14 feet of ribbon for 1x1x10 box' do
    result = Calculator.calculate_ribbon(['1x1x10'])
    expect(result).to eq 14
  end

  it 'solves part 2' do
    File.open('lib/02/input.txt') do |file|
      input = file.read
      result = Calculator.calculate_ribbon(input.split("\n"))
      expect(result).to eq 3783758
    end
  end
end
