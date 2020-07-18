class HouseFinder
  def initialize goal, multiplier, elf_limit: nil
    @houses = [0]
    @max_house = goal / 10
    @multiplier = multiplier
    @elf_limit = elf_limit
    @goal = goal
    
    initialize_houses
  end

  def initialize_houses
    1.upto(@max_house) do |house_number|
      @houses[house_number] = 0
    end
  end

  def find
    deliver_presents

    @houses.each.with_index do |presents, house_number|
      return house_number if presents >= @goal
    end
  end

  def deliver_presents
    1.upto(@max_house) do |elf_number|
      house = elf_number
      iterations = 0
      until house > @max_house || (@elf_limit != nil && iterations == @elf_limit) do
        @houses[house] += elf_number * @multiplier
        house += elf_number
        iterations += 1
      end
    end
  end
end
