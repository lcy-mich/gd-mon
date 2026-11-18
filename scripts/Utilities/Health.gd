class_name Health

#region Variables
var max_health : int
var health : int

var regen_speed : int #how much health regens per second

var dead : bool = false:
	set(value):
		dead = value
		if value: died.emit(null)
	
var living : bool :
	set(value):
		living = value
		dead = !value
	get:
		return !dead
#endregion

#region Signals
signal died(attacker : Variant)
signal hurt(damage_points : int, attacker : Variant)
signal healed(heal_poitns : int, healer : Variant)
#endregion

func _init(max_hp : int) -> void:
	max_health = max_hp
	health = max_health

#region Methods
func kill(killer : Variant) -> void:
	if dead: return
	dead = true
	health = 0
	died.emit(killer)
	
func damage(damage_points : int, attacker : Variant) -> void:
	if dead: return
	
	health -= damage_points
	if health <= 0:
		kill(attacker)
		return
	hurt.emit(damage_points, attacker)

func heal(heal_points : int, healer : Variant) -> void:
	if dead: return #you can't heal a dead man!!
	heal_points = health - max(health+heal_points, max_health)
	health += heal_points
	healed.emit(heal_points, healer)
	
func is_dead() -> bool:
	return dead
#endregion
