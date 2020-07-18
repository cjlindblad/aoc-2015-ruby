class HouseFinder
  def find(goal)
    max_house = goal / 10
    houses = [0]
    1.upto(max_house) do |house_number|
      houses[house_number] = 0
    end
    1.upto(max_house) do |elf_number|
      house = elf_number
      until house > max_house do
        houses[house] += elf_number * 10
        house += elf_number
      end
    end
    houses.each.with_index do |presents, house_number|
      return house_number if presents >= goal
    end
  end
end
