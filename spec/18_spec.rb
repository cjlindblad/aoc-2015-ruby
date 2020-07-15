require '18/solution'

describe Grid do
  it "builds starting grid from input" do
    input = File.read('lib/18/test-input.txt')
    grid = Grid.new input
    expect(grid.lights).to eq 15
  end

  it "solves part 1 example" do
    input = File.read('lib/18/test-input.txt')
    grid = Grid.new input
    4.times { grid.next }
    expect(grid.lights).to eq 4
  end

  it "solves part 1", :speed => :slow do
    input = File.read('lib/18/input.txt')
    grid = Grid.new input
    100.times { grid.next }
    expect(grid.lights).to eq 768
  end

  it "solves part 2", :speed => :slow do
    input = File.read('lib/18/input.txt')
    grid = Grid.new input
    100.times do
      grid.next
      grid.light_corners
    end
    expect(grid.lights).to eq 781
  end
end
