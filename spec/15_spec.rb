require '15/solution'

describe IngredientBalancer do
  it "solves part 1", :speed => :slow do
    balancer = IngredientBalancer.new
    File.open('lib/15/input.txt') do |file|
      file.each_line { |line| balancer.add line }
    end
    best_mix = balancer.best
    expect(best_mix).to eq 21367368
  end

  it "solves part 2", :speed => :slow do
    balancer = IngredientBalancer.new 500
    File.open('lib/15/input.txt') do |file|
      file.each_line { |line| balancer.add line }
    end
    best_mix = balancer.best
    expect(best_mix).to eq 1766400
  end
end
