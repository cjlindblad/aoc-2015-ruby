class Fight
  def initialize(hero, enemy)
    @hero = hero
    @enemy = enemy

    @initiator = @hero
    @receiver = @enemy
  end

  def switch_initiator
    @initiator, @receiver = @receiver, @initiator
  end

  def execute
    characters = [@hero, @enemy]
    until @hero.dead or @enemy.dead do
      attack = @initiator.damage - @receiver.armor
      attack = 1 if attack < 1
      @receiver.hp -= attack
      switch_initiator
    end
  end
end

class Shop
  def weapons
    [
      Item.new("Dagger", cost: 8, damage: 4),
      Item.new("Shortsword", cost: 10, damage: 5),
      Item.new("Warhammer", cost: 25, damage: 6),
      Item.new("Longsword", cost: 40, damage: 7),
      Item.new("Greataxe", cost: 74, damage: 8)
    ]
  end

  def armor
    [
      Item.new("Leather", cost: 13, armor: 1),
      Item.new("Chainmail", cost: 31, armor: 2),
      Item.new("Splintmail", cost: 53, armor: 3),
      Item.new("Bandedmail", cost: 75, armor: 4),
      Item.new("Platemail", cost: 102, armor: 5)
    ]
  end

  def rings
    [
      Item.new("Damage +1", cost: 25, damage: 1),
      Item.new("Damage +2", cost: 50, damage: 2),
      Item.new("Damage +3", cost: 100, damage: 3),
      Item.new("Defense +1", cost: 20, armor: 1),
      Item.new("Defense +2", cost: 40, armor: 2),
      Item.new("Defense +3", cost: 80, armor: 3)
    ]
  end
end

class Character
  attr_reader :name, :damage, :armor
  attr_accessor :hp

  def initialize(name, equipment: Equipment.new, hp: 100)
    @name = name
    @hp = hp
    @damage = equipment.items.reduce(0) {|sum, item| sum + item.damage}
    @armor = equipment.items.reduce(0) {|sum, item| sum + item.armor} 
  end

  def dead
    @hp <= 0
  end
end

class EquipmentIterator
  def initialize(weapons:, armor:, rings:)
    @weapons = weapons
    @armor = armor
    @rings = rings
  end

  def iterations
    equipment = []
    @weapons.each do |weapon|
      ([nil] + @armor).each do |armor|
        equipment << Equipment.new(weapon, armor)
        @rings.each do |ring|
          equipment << Equipment.new(weapon, armor, ring)
        end
        @rings.each.with_index do |ring_1, index|
          (index + 1).upto(@rings.length - 1) do |ring_2_index|
            ring_2 = @rings[ring_2_index]
            equipment << Equipment.new(weapon, armor, ring_1, ring_2)
          end
        end
      end
    end
    equipment
  end
end

class Equipment
  attr_reader :items

  def initialize(*items)
    @items = items.filter {|item| item}
  end

  def cost
    items.reduce(0) {|sum, item| sum + item.cost}
  end

  def to_s
    items.map {|item| item.name}.join(", ")
  end
end

class Item
  attr_reader :name, :cost, :damage, :armor

  def initialize(name, cost: 0, damage: 0, armor: 0)
    @name = name
    @cost = cost
    @damage = damage
    @armor = armor
  end
end

