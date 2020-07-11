class Grid
  def initialize input
    @grid = []
    input.split("\n").each_with_index do |line, y|
      @grid[y] = []
      line.split("").each_with_index do |char, x|
        @grid[y][x] = char == "#" ? :on : :off
      end
    end
  end

  def lights
    @grid.flatten.count :on 
  end

  def next
    next_grid = []
    @grid.each_with_index do |line, y|
      next_grid[y] = []
      line.each_with_index do |light, x|
        next_light = :off
        neighbours = lit_neighbours(y, x)
        case light
        when :on
          next_light = (neighbours == 2 || neighbours == 3) ? :on : :off
        when :off
          next_light = neighbours == 3 ? :on : :off
        end
        next_grid[y][x] = next_light 
      end
    end
    @grid = next_grid
  end

  def lit_neighbours y, x
    offsets = [
      [1, 1],
      [1, 0],
      [1, -1],
      [0, 1],
      [0, -1],
      [-1, 1],
      [-1, 0],
      [-1, -1]
    ]

    neighbours = 0

    offsets.each do |offset|
      next_y = y + offset.first
      next_x = x + offset.last
      next if next_y < 0 || next_x < 0 || @grid[next_y].nil?
      neighbours += 1 if @grid[next_y][next_x] == :on 
    end

    neighbours
  end
end
