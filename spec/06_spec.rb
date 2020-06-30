require '06/solution'

describe "Day 6 part 1" do
  before :each do
    @grid = LightGrid.new
  end

  it "can turn on every light", :speed => :slow do
    @grid.parse_instruction "turn on 0,0 through 999,999"
    expect(@grid.lights_lit).to eq 1000000
  end 

  it "can toggle 1000 lights" do
    @grid.parse_instruction "toggle 0,0 through 999,0"
    expect(@grid.lights_lit).to eq 1000
    @grid.parse_instruction "toggle 0,0 through 999,0"
    expect(@grid.lights_lit).to eq 0
  end

  it "can turn off 4 lights", :speed => :slow do
    @grid.parse_instruction "turn on 0,0 through 999,999"
    @grid.parse_instruction "turn off 499,499 through 500,500"
    expect(@grid.lights_lit).to eq 999996
  end

  it "solves part 1", :speed => :slow do
    File.open('lib/06/input.txt') do |file|
      file.each_line { |line| @grid.parse_instruction line }
    end
    expect(@grid.lights_lit).to eq 569999
  end
end

describe "Day 6 part 2" do
  before :each do
    @grid = LightGrid.new
  end

  it "solves part 2", :speed => :slow do
    File.open('lib/06/input.txt') do |file|
      file.each_line { |line| @grid.parse_instruction line }
    end
    expect(@grid.brightness).to eq 17836115
  end
end
