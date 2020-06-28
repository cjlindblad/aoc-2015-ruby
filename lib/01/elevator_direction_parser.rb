class Parser
  def self.parse(direction)
    direction.count('(') - direction.count(')')
  end

  def self.find_basement_entry_position(direction)
    floor = 0
    direction.split('').each_with_index do |char, index|
      floor += 1 if char == '('
      floor -= 1 if char == ')'
      return index + 1 if floor < 0
    end
  end
end


