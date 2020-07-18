require '20/solution'

describe HouseFinder do
  it "finds that house #8 is the first to receive 150 presents" do
    finder = HouseFinder.new
    present_goal = 150
    house_number = finder.find(present_goal)
    expect(house_number).to eq 8
  end

  it "find that house #12 is the first to receive 280 presents" do
    finder = HouseFinder.new
    present_goal = 280
    house_number = finder.find(present_goal)
    expect(house_number).to eq 12
  end

  it "solves part 1", :speed => :slow do
    finder = HouseFinder.new
    present_goal = 33100000
    house_number = finder.find(present_goal)
    expect(house_number).to eq 776160
  end

  it "solves part 2" do
    finder = HouseFinder.new
    present_goal = 33100000
    house_number = finder.find_2(present_goal)
    expect(house_number).to eq 786240
  end
end
