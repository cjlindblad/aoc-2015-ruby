require '17/solution'

describe Packer do
  it "finds four ways to pack 25 litres in [20, 15, 10, 5, 5]" do
    eggnog = 25
    containers = [20, 15, 10, 5, 5]
    packer = Packer.new eggnog, containers
    packer.pack
    expect(packer.combinations.length).to eq 4 
  end

  it "solves part 1", :speed => :slow do
    containers = []
    File.open('lib/17/input.txt') do |file|
      file.each_line do |line|
        containers.push(line.to_i)
      end
    end
    packer = Packer.new 150, containers
    packer.pack
    expect(packer.combinations.length).to eq 1304
  end

  it "solves part 2", :speed => :slow do
    containers = []
    File.open('lib/17/input.txt') do |file|
      file.each_line do |line|
        containers.push(line.to_i)
      end
    end
    packer = Packer.new 150, containers
    packer.pack
    combinations = packer.combinations
    combinations.sort_by! { |e| e.length }
    result = 0
    target_length = combinations.first.length
    index = 0
    while combinations[index].length == target_length
      result += 1
      index += 1
    end
    expect(result).to eq 18
  end
end
