class_name StatusBar
extends Control

#region Exports
@export var Animator : AnimationPlayer
@export var is_opponent : bool = true
@export var health_bar : ProgressBar
@export var pokemons : Dictionary[Battle.BATTLE_POSITIONS, Pokemon]
@export var name_label : Label
@export var level_label : Label
@export var health_label : Label
#endregion

var is_linked : bool = false
var tweening_health : bool = false

func _ready() -> void:
	Animator.play("opponent_enter" if is_opponent else "player_enter")
	
func _process(_delta: float) -> void:
	if !is_linked: return
	
	# for now only single battles are implemented, so pokemons can be assumed to only contain the middle position.
	var pokemon : Pokemon = pokemons[Battle.BATTLE_POSITIONS.Middle]
	
	if !pokemon.is_fully_loaded(): return
	
	var pokemon_health : Health = pokemon.health_component
	
	health_bar.max_value = pokemon_health.max_health
	health_label.text = "%03d/%03d" % [pokemon_health.health, pokemon_health.max_health]
	
	if pokemon_health.health != health_bar.value and !tweening_health:
		tweening_health = true
		var health_tween : Tween = create_tween()
		@warning_ignore("return_value_discarded")
		health_tween.tween_property(health_bar, "value", pokemon_health.health, 0.2)
		@warning_ignore("return_value_discarded")
		health_tween.tween_callback(func() -> void:
			health_bar.value = pokemon_health.health 
			tweening_health = false
		)
		
	name_label.text = pokemon.data.name
	level_label.text = "LVL %03d" %  pokemon.stats.level
	
func link(p : Dictionary[Battle.BATTLE_POSITIONS, Pokemon]) -> void:
	pokemons = p
	
	is_linked = true
	
		
