require '13/solution'

describe SeatingPlanner do
  it "finds optimal seating for test input" do
    planner = SeatingPlanner.new
    File.open('lib/13/test-input.txt') do |file|
      file.each_line { |line| planner.add_preference line }
    end
    result = planner.optimal_happiness
    expect(result).to eq 330
  end

  it "solves part 1" do
    planner = SeatingPlanner.new
    File.open('lib/13/input.txt') do |file|
      file.each_line { |line| planner.add_preference line }
    end
    result = planner.optimal_happiness
    expect(result).to eq 664
  end
end
