class Warrior
  attr_accessor :level, :weapon, :str, :vitality
  def initialize(level)
    @level = level
    @weapon = nil
    @str = @level * 10
    @vitality = @level * 5
  end

  def level_up
    @level += 1
    @str += 10
    @vitality += 5
  end

  def pick_up_weapon(weapon)
    @weapon = weapon
    @str += weapon.str
  end

  def drop_weapon
    @str = level * 10
  end

  def calculate_damage(dmg_type)
    modifier = @str * 0.01
    modifier * dmg_type
  end

  def check_element(type)
    if type == @weapon.element_type
      @weapon.element_percent
    else
      1
    end
  end

  def calculate_dps(min, max)
    ((min * @weapon.aps) + (max * @weapon.aps)) / 2
  end

  def punch
    stats = []
    min = calculate_damage(@weapon.dmg_min) * check_element('physical')
    max = calculate_damage(@weapon.dmg_max) * check_element('physical')
    stats << "Minimum: #{min}"
    stats << "Maximum: #{max}"
    stats << "DPS: #{calculate_dps(min, max)}"
  end

  def smite
    stats = []
    min = calculate_damage(@weapon.dmg_min) * 0.9 * check_element('fire')
    max = calculate_damage(@weapon.dmg_max) * 0.9 * check_element('fire')
    stats << "Minimum: #{min}"
    stats << "Maximum: #{max}"
    stats << "DPS: #{calculate_dps(min, max) * 1.2}"
  end

  def cleave
    stats = []
    min = calculate_damage(@weapon.dmg_min) * 1.2 * check_element('cold')
    max = calculate_damage(@weapon.dmg_max) * 1.2 * check_element('cold')
    stats << "Minimum: #{min}"
    stats << "Maximum: #{max}"
    stats << "DPS: #{calculate_dps(min, max) * 0.9}"
  end
end

class Weapon
  attr_accessor :dmg_max, :dmg_min, :str, :aps, :element_type, :element_percent
  def initialize(dmg, str, aps, element, element_percent)
    @dmg_min = dmg[0]
    @dmg_max = dmg[1]
    @str = str
    @aps = aps
    @element_type = element
    @element_percent = element_percent
  end
end

mace = Weapon.new([70, 85], 20, 1.0, nil, 0)
axe = Weapon.new([50, 65], 20, 1.2, nil, 0)
sword = Weapon.new([30, 45], 20, 1.4, nil, 0)
antarctic_mace = Weapon.new([70, 85], 20, 1.0, 'cold', 1.2)
axe_of_hades = Weapon.new([50, 65], 20, 1.2, 'fire', 1.1)
lets_get_physical_sword = Weapon.new([30, 45], 20, 1.4, 'physical', 1.05)

lena = Warrior.new(10)

lena.pick_up_weapon(mace)

p lena.punch
p lena.smite
p lena.cleave

lena.drop_weapon
lena.pick_up_weapon(axe)
p "**************************"

p lena.punch
p lena.smite
p lena.cleave

lena.drop_weapon
lena.pick_up_weapon(sword)
p "**************************"

p lena.punch
p lena.smite
p lena.cleave

lena.drop_weapon
lena.pick_up_weapon(antarctic_mace)
p "**************************"

p lena.punch
p lena.smite
p lena.cleave

lena.drop_weapon
lena.pick_up_weapon(axe_of_hades)
p "**************************"

p lena.punch
p lena.smite
p lena.cleave

lena.drop_weapon
lena.pick_up_weapon(lets_get_physical_sword)
p "**************************"

p lena.punch
p lena.smite
p lena.cleave

# to get the answers in the example: Punch, Minimum/maximum = min/max_dmg * 1.2 (because of the 20 STR 
# - 1% bonus to attack for every 1 STR. Using base damage because the punch is 100% dmg and aps.
# ) DPS: for the axe, it's punch_damage_min * 1.2 (because axes attack at 20% faster than maces, which attack
# at 1), + punch_damage_max * 1.2 / 2. 
