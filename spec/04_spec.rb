require '04/solution'

RSpec.describe "Day 4 part 1 solution" do
  it "finds 609043 for abcdef", :speed => :slow do
    match = /\A0{5}/
    miner = Miner.new 'abcdef'
    result = miner.find match
    expect(result).to eq 609043
  end
  
  it "finds 1048970 for pqrstuv", :speed => :slow do
    match = /\A0{5}/
    miner = Miner.new 'pqrstuv'
    result = miner.find match
    expect(result).to eq 1048970
  end

  it "solves part 1", :speed => :slow do
    match = /\A0{5}/
    miner = Miner.new 'ckczppom'
    result = miner.find match
    expect(result).to eq 117946
  end
end

RSpec.describe "Day 4 part 2 solution", :speed => :slow do
  it "solves part 2" do
    match = /\A0{6}/
    miner = Miner.new 'ckczppom'
    result = miner.find match
    expect(result).to eq 3938038
  end
end
