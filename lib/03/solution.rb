require 'set'

class Route
  def initialize
    @x = 0
    @y = 0
    @visited = Set.new()
    add_position_to_visited
  end

  def add_directions!(directions)
    directions.each_char { |char| add_direction! char }
  end

  def add_direction!(direction)
    case direction
    when '^'
      @y -= 1
    when '>'
      @x += 1
    when 'v'
      @y += 1
    when '<'
      @x -= 1
    end
    add_position_to_visited
  end

  def add_position_to_visited()
    @visited.add([@x, @y])
  end

  def visited_houses()
    @visited.size
  end
end

