require '22/solution'

describe BaseCharacter do
  it "can kill another character" do
    char_1 = BaseCharacter.new(attack: 5)
    char_2 = BaseCharacter.new(hp: 5)
    char_1.attack(char_2)
    expect(char_2.dead).to be true
  end

  it "can attack another character without killing it" do
    char_1 = BaseCharacter.new(attack: 5)
    char_2 = BaseCharacter.new(hp: 6)
    char_1.attack(char_2)
    expect(char_1.alive).to be true
  end

  it "can reduce attack value with armor" do
    char_1 = BaseCharacter.new(attack: 5)
    char_2 = BaseCharacter.new(hp: 5, armor: 1)
    char_1.attack(char_2)
    expect(char_2.alive).to be true
    expect(char_2.hp).to be 1
  end

  it "always deals at least one damage, regardless of armor" do
    char_1 = BaseCharacter.new(attack: 1)
    char_2 = BaseCharacter.new(hp: 1, armor: 10000)
    char_1.attack(char_2)
    expect(char_2.dead).to be true
  end
end

describe Wizard do
  it "can damage opponent with magic missile" do
    wizard = Wizard.new(mana: 100)
    enemy = BaseCharacter.new(hp: 5)
    wizard.cast(:magic_missile, enemy)
    expect(enemy.hp).to eq 1
    expect(wizard.mana).to eq 47
  end

  it "cannot cast spell without enough mana" do
    wizard = Wizard.new(mana: 0)
    enemy = BaseCharacter.new()
    expect { wizard.cast(:magic_missile, enemy) }.to raise_error "Not enough mana"
  end

  it "can damage and heal with drain" do
    wizard = Wizard.new(hp: 2, mana: 100)
    enemy = BaseCharacter.new(hp: 3)
    wizard.cast(:drain, enemy)
    expect(enemy.hp).to eq 1
    expect(wizard.hp).to eq 4
    expect(wizard.mana).to eq 27
  end

  it "gains shield armor for six turns" do
    wizard = Wizard.new(mana: 120)
    wizard.cast(:shield)
    expect(wizard.armor).to eq 0
    6.times { wizard.resolve_turn }
    expect(wizard.armor).to eq 7
    1.times { wizard.resolve_turn }
    expect(wizard.armor).to eq 0
  end

  it "damages enemy over six turns with poison" do
    wizard = Wizard.new(mana: 200)
    enemy = BaseCharacter.new(hp: 18)
    wizard.cast(:poison, enemy)
    5.times { wizard.resolve_turn }
    expect(enemy.hp).to eq 3
    1.times { wizard.resolve_turn }
    expect(enemy.dead).to be true
  end

  it "gains mana with recharge" do
    wizard = Wizard.new(mana: 229)
    wizard.cast(:recharge)
    5.times { wizard.resolve_turn }
    expect(wizard.mana).to eq 505
    100.times { wizard.resolve_turn }
    expect(wizard.mana).to eq 505
  end

  it "can't cast a spell that's already active" do
    wizard = Wizard.new(mana: 1000)
    wizard.cast(:shield)
    5.times { wizard.resolve_turn }
    expect(wizard.can_cast?(:shield)).to be false
  end

  it "can cast a spell on the same turn an effect ends" do
    wizard = Wizard.new(mana: 1000)
    wizard.cast(:shield)
    6.times { wizard.resolve_turn }
    expect(wizard.can_cast?(:shield)).to be true
  end

  it "can play out first example scenario" do
    wizard = Wizard.new(hp: 10, mana: 250)
    boss = BaseCharacter.new(hp: 13, attack: 8)

    wizard.cast(:poison, boss)

    wizard.resolve_turn
    boss.attack(wizard)

    wizard.cast(:magic_missile, boss)
    
    wizard.resolve_turn
    # boss is killed before it can act

    expect(boss.dead).to be true
    expect(wizard.hp).to be 2
    expect(wizard.mana).to be 24
    expect(wizard.armor).to be 0
  end

  it "can play out second example scenario" do
    wizard = Wizard.new(hp: 10, mana: 250)
    boss = BaseCharacter.new(hp: 14, attack: 8)

    wizard.cast(:recharge)

    wizard.resolve_turn
    boss.attack(wizard)

    wizard.cast(:shield)

    wizard.resolve_turn
    boss.attack(wizard)

    wizard.cast(:drain, boss)

    wizard.resolve_turn
    boss.attack(wizard)

    wizard.cast(:poison, boss)

    wizard.resolve_turn
    boss.attack(wizard)

    wizard.cast(:magic_missile, boss)

    wizard.resolve_turn

    expect(boss.dead).to be true
    expect(wizard.hp).to eq 1
    expect(wizard.mana).to eq 114
    expect(wizard.armor).to eq 0
  end
end


