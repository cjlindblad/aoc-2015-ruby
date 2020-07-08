class Packer
  attr_reader :combinations

  def initialize eggnog, containers
    @eggnog = eggnog
    @containers = containers
    @combinations = 0
  end

  def pack
    0.upto((2 ** @containers.length) - 1) do |n|
      binary_string = n.to_s(2).rjust(@containers.length, "0")
      candidate = 0
      binary_string.each_char.with_index do |char, index|
        candidate += @containers[index] if char == "1" 
      end
      @combinations += 1 if candidate == @eggnog
    end 
  end
end
