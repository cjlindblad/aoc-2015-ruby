class IngredientBalancer
  def initialize calorie_goal=nil
    @calorie_goal = calorie_goal
    @ingredients = []
  end

  def add ingredient
    name = ingredient.match(/^(\w+):/).captures.first
    capacity = ingredient.match(/capacity (-?\d+)/).captures.first.to_i
    durability = ingredient.match(/durability (-?\d+)/).captures.first.to_i
    flavor = ingredient.match(/flavor (-?\d+)/).captures.first.to_i
    texture = ingredient.match(/texture (-?\d+)/).captures.first.to_i
    calories = ingredient.match(/calories (-?\d+)/).captures.first.to_i

    @ingredients.push(Ingredient.new(
      name,
      capacity,
      durability,
      flavor,
      texture,
      calories))
  end
  
  def score_for i, j, k, l
    weights = [i, j, k, l]
    names = [:capacity, :durability, :flavor, :texture, :calories]
    values = {}
    names.map do |name|
      value = 0
      @ingredients.each_with_index do |ingredient, index|
        value += ingredient.send(name) * weights[index]
      end
     values[name] = value 
     values[name] = 0 if values[name] < 0
    end
    score = 1
    score *= values[:capacity]
    score *= values[:durability]
    score *= values[:flavor]
    score *= values[:texture]
    
    return 0 if values[:calories] != @calorie_goal

    return score
  end
  
  def best
    best_score = 0

    values = 0.upto(100).to_a
    values.each do |i|
      values.each do |j|
        values.each do |k|
          values.each do |l|
            if i + j + k + l == 100
              score = score_for(i, j, k, l)
              best_score = score if score > best_score
            end
          end
        end
      end
    end

    best_score
  end
end

class Ingredient
  attr_reader :name, :capacity, :durability
  attr_reader :flavor, :texture, :calories

  def initialize name, capacity, durability, flavor, texture, calories
    @name = name
    @capacity = capacity
    @durability = durability
    @flavor = flavor
    @texture = texture
    @calories = calories
  end
end
