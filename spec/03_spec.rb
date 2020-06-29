require "03/solution"

RSpec.describe "Day 3 part 1" do
  it "delivers to 2 houses with >" do
    route = Route.new
    route.add_direction! '>'
    expect(route.visited_houses).to eq 2
  end

  it "delivers to 4 houses with ^>v<" do
    route = Route.new
    route.add_directions! "^>v<" 
    expect(route.visited_houses).to eq 4
  end

  it "delivers to 2 houses with ^v^v^v^v^v" do
    route = Route.new
    route.add_directions! "^v^v^v^v^v"
    expect(route.visited_houses).to eq 2
  end

  it "solves part 1" do
    File.open('lib/03/input.txt') do |file|
      input = file.read
      route = Route.new
      route.add_directions! input
      expect(route.visited_houses).to eq 2565
    end
  end
end
