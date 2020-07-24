class BaseCharacter
  attr_accessor :hp, :armor
  attr_reader :attack

  def initialize(hp: 10, attack: 0, armor: 0)
    @hp = hp
    @attack = attack
    @armor = armor
  end

  def attack(opponent)
    attack_value = @attack - opponent.armor
    attack_value = 1 if attack_value < 1
    opponent.hp -= attack_value
  end

  def resolve_turn
    # used for resolving passive effects
  end

  def dead
    @hp <= 0
  end

  def alive
    not dead
  end
end

class Wizard < BaseCharacter
  attr_accessor :mana

  def initialize(mana: 0, **args)
    super(args)
    @mana = mana
    @active_spells = []
  end

  def cast(spell_name, target=nil)
    resolve_turn
    spell = SpellBook.create(spell_name)
    raise StandardError.new("Not enough mana") if @mana < spell.cost
    @mana -= spell.cost
    spell.cast(self, target)
    @active_spells << spell
  end

  def can_cast?(spell_name)
    spell = SpellBook.create(spell_name)
    spell.cost <= @mana && @active_spells.all? {|spell| spell.name != spell_name || spell.turns == 0}
  end

  def resolve_turn
    remove_inactive_spells
    apply_active_spells
  end

  def apply_active_spells
    @active_spells.each {|spell| spell.apply }
  end

  def remove_inactive_spells
    @active_spells.each {|spell| spell.inactivate if spell.turns < 1}
    @active_spells.filter! {|spell| spell.turns > 0}
  end
end

class Spell
  attr_reader :name, :cost, :turns

  def initialize
    @turns = 1
  end

  def cast(caster, target)
    @caster = caster
    @target = target
  end

  def apply
    @turns -= 1
  end

  def inactivate
  end
end

class MagicMissile < Spell
  def initialize
    super
    @name = :magic_missile
    @cost = 53
  end

  def cast(caster, target)
    super
    @target.hp -= 4
  end
end

class Drain < Spell
  def initialize
    super
    @name = :drain
    @cost = 73
  end

  def cast(caster, target)
    super
    @target.hp -= 2
    @caster.hp += 2
  end
end

class Shield < Spell
  def initialize
    super
    @name = :shield
    @cost = 113
    @turns = 6
  end

  def apply
    super
    @caster.armor = 7
  end

  def inactivate
    @caster.armor = 0
  end
end

class Poison < Spell
  def initialize
    super
    @name = :poison
    @cost = 173
    @turns = 6
  end

  def apply
    super
    @target.hp -= 3
  end
end

class Recharge < Spell
  def initialize
    super
    @name = :recharge
    @cost = 229
    @turns = 5
  end

  def apply
    super
    @caster.mana += 101
  end
end

class SpellBook
  def self.create(spell_name)
    case spell_name
    when :magic_missile
      MagicMissile.new
    when :drain
      Drain.new
    when :shield
      Shield.new
    when :poison
      Poison.new
    when :recharge
      Recharge.new
    else
      raise StandardError.new("Invalid spell name #{spell_name}")
    end
  end
end
