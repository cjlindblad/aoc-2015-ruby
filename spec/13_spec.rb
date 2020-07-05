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

  it "solves part 1", :speed => :slow do
    planner = SeatingPlanner.new
    File.open('lib/13/input.txt') do |file|
      file.each_line { |line| planner.add_preference line }
    end
    result = planner.optimal_happiness
    expect(result).to eq 664
  end

  it "solves part 2", :speed => :slow do
    planner = SeatingPlanner.new
    File.open('lib/13/input.txt') do |file|
      file.each_line { |line| planner.add_preference line }
    end
    planner.add_me
    result = planner.optimal_happiness
    expect(result).to eq 640
  end
end
