require '01/elevator_direction_parser'

RSpec.describe 'day 1 solution part 1' do
  it 'parses (()) and ()() to be floor 0' do
    expect(Parser.parse('()()')).to eq 0
    expect(Parser.parse('(())')).to eq 0
  end

  it 'parses ((( and (()(()( to be floor 3' do
    expect(Parser.parse('(((')).to eq 3
    expect(Parser.parse('(()(()(')).to eq 3
  end

  it 'parses ))((((( to be floor 3' do
    expect(Parser.parse('))(((((')).to eq 3
  end

  it 'parses ()) and ))( to be floor -1' do
    expect(Parser.parse('())')).to eq -1
    expect(Parser.parse('))(')).to eq -1
  end

  it 'parses ))) and )())()) to be floor -3' do
    expect(Parser.parse(')))')).to eq -3
    expect(Parser.parse(')())())')).to eq -3
  end

  it 'solves part 1' do
    file = File.open('lib/01/input.txt')
    input = file.read
    expect(Parser.parse(input)).to eq 232
  end
end

RSpec.describe 'day 1 solution part 2' do
  it 'finds position 1 from )' do
    expect(Parser.find_basement_entry_position(')')).to eq 1
  end

  it 'finds position 5 from ()())' do
    expect(Parser.find_basement_entry_position('()())')).to eq 5
  end

  it 'solves part 2' do
    file = File.open('lib/01/input.txt')
    input = file.read
    expect(Parser.find_basement_entry_position(input)).to eq 1783
  end
end
