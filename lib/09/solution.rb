class Graph
  def initialize
    @nodes = {} 
  end

  def add route 
    unless @nodes.include? route.from
      @nodes[route.from] = []
    end
    unless @nodes.include? route.to
      @nodes[route.to] = []
    end

    @nodes[route.from].push(Edge.new route.to, route.distance)
    @nodes[route.to].push(Edge.new route.from, route.distance)
  end

  def shortest_route
    @distances = []
    @nodes.keys.each do |node_name|
      search node_name, [node_name], 0
    end
    @distances.sort.first
  end

  def search node_name, visited, distance
    if visited.length == @nodes.keys.length
      @distances.push(distance)
    end
    edges = @nodes[node_name]
    edges.each do |edge|
      unless visited.include? edge.to
        search edge.to, visited.clone.push(edge.to), distance + edge.distance
      end
    end
  end

  def to_s
    @nodes.to_s
  end
end

class Edge
  attr_reader :to, :distance

  def initialize to, distance
    @to = to
    @distance = distance
  end

  def to_s
    "#{@to} (#{@distance})"
  end
end

class Route
  attr_reader :from, :to, :distance

  def initialize from, to, distance
    @from = from
    @to = to
    @distance = distance
  end

  def self.parse string
    string.match /(\w+) to (\w+) = (\d+)/
    from = $1.to_sym
    to = $2.to_sym
    distance = $3.to_i
    Route.new from, to, distance
  end

  def to_s
    "#{@from} to #{@to} -> #{@distance}"
  end
end
