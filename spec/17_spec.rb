require '17/solution'

describe Packer do
  it "finds four ways to pack 25 litres in [20, 15, 10, 5, 5]" do
    eggnog = 25
    containers = [20, 15, 10, 5, 5]
    packer = Packer.new eggnog, containers
    packer.pack
    expect(packer.combinations).to eq 4 
  end

  it "solves part 1" do
    containers = []
    File.open('lib/17/input.txt') do |file|
      file.each_line do |line|
        containers.push(line.to_i)
      end
    end
    packer = Packer.new 150, containers
    packer.pack
    expect(packer.combinations).to eq 0
  end
end
