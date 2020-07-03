require '10/solution'

describe LookAndSay do
  it "solves part 1", :speed => :slow do
    solver = LookAndSay.new
    value = "1321131112"
    40.times do |n|
      puts n
      value = LookAndSay.next value
    end 
    expect(value.length).to eq 492982
  end
end
