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

  it "find the first house that receives 33100000 presents", :speed => :slow do
    finder = HouseFinder.new
    present_goal = 33100000
    house_number = finder.find(present_goal)
    expect(house_number).to eq 776160
  end
end


#   1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 20
#01 X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X
#02    X     X     X     X     X     X     X     X     X     X
#03       X        X        X        X        X        X
#04          X           X           X           X           X
#05             X              X              X              X
#06                X                 X                 X
#07                   X                    X       
#08                      X                       X
#09                         X                          X
#10                            X                             X    
#11                               X
#12                                  X
#13
#14
#15
#16
#17
#18
#19
#20

