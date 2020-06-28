class Parser
  def self.parse(direction)
    direction.count('(') - direction.count(')')
  end
end


