require '21/solution'

describe EquipmentIterator do
  it "iterates over all equipment combinations" do
    weapons = [
      Item.new("dagger", cost: 8, damage: 4, armor: 0),
      Item.new("shortsword", cost: 10, damage: 5, armor: 0)
    ]
    armor = [
      Item.new("leather", cost: 13, damage: 0, armor: 1)
    ]
    rings = [
      Item.new("damage +1", cost: 25, damage: 1, armor: 0),
      Item.new("defense +1", cost: 20, damage: 1, armor: 1)
    ]
    iterator = EquipmentIterator.new(
      weapons: weapons,
      armor: armor,
      rings: rings,
    )
    variations = iterator.iterations
    item_names = variations.map {|equipment| equipment.to_s}
    expected = [
      "dagger",
      "dagger, damage +1",
      "dagger, defense +1",
      "dagger, damage +1, defense +1",
      "dagger, leather",
      "dagger, leather, damage +1",
      "dagger, leather, defense +1",
      "dagger, leather, damage +1, defense +1",
      "shortsword",
      "shortsword, damage +1",
      "shortsword, defense +1",
      "shortsword, damage +1, defense +1",
      "shortsword, leather",
      "shortsword, leather, damage +1",
      "shortsword, leather, defense +1",
      "shortsword, leather, damage +1, defense +1",
    ] 
    expect(item_names).to eq expected
  end
end

describe Character do
  it "has base stats without equipment" do
    hero = Character.new("hero")
    expect(hero.hp).to eq 100
    expect(hero.damage).to eq 0
    expect(hero.armor).to eq 0
  end
  
  it "can have custom hp" do
    hero = Character.new("hero", hp: 110)
    expect(hero.hp).to eq 110
  end

  it "has altered stats with equipment" do
    equipment = Equipment.new(
      Item.new("dagger", damage: 4),
      Item.new("leather", armor: 1),
      Item.new("damage +1", damage: 1),
      Item.new("defense +1", armor: 1)
    )
    hero = Character.new("hero", equipment: equipment)
    expect(hero.damage).to eq 5
    expect(hero.armor).to eq 2
  end
end

describe Fight do
  it "plays out example fight with hero as winner" do
    hero_equipment = Equipment.new(
      Item.new("weapon", damage: 5),
      Item.new("armor", armor: 5)
    )
    boss_equipment = Equipment.new(
      Item.new("weapon", damage: 7),
      Item.new("armor", armor: 2)
    )
    hero = Character.new("hero", hp: 8, equipment: hero_equipment)
    boss = Character.new("boss", hp: 12, equipment: boss_equipment)

    fight = Fight.new(hero, boss)
    fight.execute

    expect(hero.hp).to eq 2
    expect(boss.hp).to eq 0
  end

  it "solves part 1" do
    boss_equipment = Equipment.new(
      Item.new("weapon", damage: 8),
      Item.new("armor", armor: 1)
    )

    shop = Shop.new
    equipment_iterator = EquipmentIterator.new(
      weapons: shop.weapons,
      armor: shop.armor,
      rings: shop.rings
    )
    hero_equipment = equipment_iterator.iterations
    best_cost = 1000000000
    hero_equipment.each do |equipment|
      hero = Character.new("hero", hp: 100, equipment: equipment)
      boss = Character.new("boss", hp: 104, equipment: boss_equipment)
      fight = Fight.new(hero, boss)
      fight.execute
      if boss.dead && equipment.cost < best_cost
        best_cost = equipment.cost
      end
    end
    
    expect(best_cost).to eq 78
  end

  it "solves part 2" do
    boss_equipment = Equipment.new(
      Item.new("weapon", damage: 8),
      Item.new("armor", armor: 1)
    )

    shop = Shop.new
    equipment_iterator = EquipmentIterator.new(
      weapons: shop.weapons,
      armor: shop.armor,
      rings: shop.rings
    )
    hero_equipment = equipment_iterator.iterations
    worst_cost = 0
    hero_equipment.each do |equipment|
      hero = Character.new("hero", hp: 100, equipment: equipment)
      boss = Character.new("boss", hp: 104, equipment: boss_equipment)
      fight = Fight.new(hero, boss)
      fight.execute
      if hero.dead && equipment.cost > worst_cost
        worst_cost = equipment.cost
      end
    end
    
    expect(worst_cost).to eq 148
  end
end

