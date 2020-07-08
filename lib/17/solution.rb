class Packer
  attr_reader :combinations

  def initialize eggnog, containers
    @eggnog = eggnog
    @containers = containers
    @combinations = []
  end

  def pack
    0.upto((2 ** @containers.length) - 1) do |n|
      binary_string = n.to_s(2).rjust(@containers.length, "0")
      candidate = []
      binary_string.each_char.with_index do |char, index|
        candidate.push(@containers[index]) if char == "1" 
      end
      @combinations.push(candidate) if candidate.sum == @eggnog
    end 
  end
end
