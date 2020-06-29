require "03/solution"

RSpec.describe "Day 3 part 1" do
  it "delivers to 2 houses with >" do
    santa = Santa.new
    santa.add_direction! '>'
    expect(santa.visited_houses).to eq 2
  end

  it "delivers to 4 houses with ^>v<" do
    santa = Santa.new
    santa.add_directions! "^>v<" 
    expect(santa.visited_houses).to eq 4
  end

  it "delivers to 2 houses with ^v^v^v^v^v" do
    santa = Santa.new
    santa.add_directions! "^v^v^v^v^v"
    expect(santa.visited_houses).to eq 2
  end

  it "solves part 1" do
    File.open('lib/03/input.txt') do |file|
      input = file.read
      santa = Santa.new
      santa.add_directions! input
      expect(santa.visited_houses).to eq 2565
    end
  end
end

RSpec.describe "Day 3 part 2" do
  it "delivers to 3 houses with ^v" do
    santa = Santa.new
    robot_santa = Santa.new

    input = '^v'
    santa.add_directions! input.even_chars
    robot_santa.add_directions! input.odd_chars

    expect(santa.visited_houses_with(robot_santa)).to eq 3
  end

  it "delivers to 3 houses with ^>v<" do
    santa = Santa.new
    robot_santa = Santa.new

    input = "^>v<"
    santa.add_directions! input.even_chars
    robot_santa.add_directions! input.odd_chars

    expect(santa.visited_houses_with(robot_santa)).to eq 3
  end
  
  it "delivers to 11 houses with ^v^v^v^v^v" do
    santa = Santa.new
    robot_santa = Santa.new

    input = "^v^v^v^v^v"
    santa.add_directions! input.even_chars
    robot_santa.add_directions! input.odd_chars

    expect(santa.visited_houses_with(robot_santa)).to eq 11
  end

  it "solves part 2" do
    santa = Santa.new
    robot_santa = Santa.new

    File.open('lib/03/input.txt') do |file|
      input = file.read
      santa.add_directions! input.even_chars
      robot_santa.add_directions! input.odd_chars
      
      expect(santa.visited_houses_with(robot_santa)).to eq 2639
    end
  end
end
