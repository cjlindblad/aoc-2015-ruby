require '10/solution'

describe LookAndSay do
  it "solves part 1", :speed => :slow do
    solver = LookAndSay.new
    value = "1321131112"
    40.times do |n|
      value = LookAndSay.next value
    end 
    expect(value.length).to eq 492982
  end

  it "solves part 2", :speed => :slow do
    sovler = LookAndSay.new
    value = "1321131112"
    50.times do |n|
      value = LookAndSay.next value
    end
    expect(value.length).to eq 6989950
  end
end
