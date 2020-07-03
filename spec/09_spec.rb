require '09/solution'

describe Graph do
  it "finds shortes route for three cities" do
    input = "London to Dublin = 464
    London to Belfast = 518
    Dublin to Belfast = 141"

    graph = Graph.new
    input.each_line do |line|
      route = Route.parse(line.strip)
      graph.add(route)
    end 
    expect(graph.shortest_route).to eq 605
  end

  it "solves part 1", :speed => :slow do
    graph = Graph.new
    File.open('lib/09/input.txt') do |file|
      file.each_line do |line|
        route = Route.parse(line.strip)
        graph.add(route)
      end
    end
    expect(graph.shortest_route).to eq 251
  end

  it "solves part 2", :speed => :slow do
    graph = Graph.new
    File.open('lib/09/input.txt') do |file|
      file.each_line do |line|
        route = Route.parse(line.strip)
        graph.add(route)
      end
    end
    expect(graph.longest_route).to eq 898
  end
end
