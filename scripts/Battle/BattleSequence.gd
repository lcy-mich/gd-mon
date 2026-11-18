extends Node2D

#region Exports
@export var opponents : Dictionary[Battle.BATTLE_POSITIONS, Pokemon]
@export var allies : Dictionary[Battle.BATTLE_POSITIONS, Pokemon]

@export_category("Nodes")
@export var opponent_battle : Battle
@export var player_battle : Battle

@export var battle_ui : BattleUI
#endregion

#region Variables
var in_battle : bool = false
#endregion

func _ready() -> void:
	#region Globals setup
	if Global.player_pokemons:
		allies = Global.player_pokemons
	if Global.opponent_pokemons:
		opponents = Global.opponent_pokemons
	Global.clean_data()
	#endregion
	
	#region Battles setup
	if len(opponents) > 0:
		opponent_battle.pokemons = opponents
	if len(allies) > 0:
		player_battle.pokemons = allies
	#endregion
	
	#region BattleUI setup
	battle_ui.run_pressed.connect(func() -> void:
		Global.win()
		go_main()
		)
	#endregion
	
	in_battle = true
	
func _process(_delta : float) -> void:
	if !in_battle: return
	
	var allies_alive : bool = allies.values().any(is_living)
	var opps_alive : bool = opponents.values().any(is_living)
	
	if !(opps_alive and allies_alive):
		in_battle = false
	
		if (opps_alive and !allies_alive): 
			Global.lose()
		elif (!opps_alive and allies_alive):
			Global.win()
		else:
			Global.draw()
			
		call_deferred("go_main")
		return
		
#region Methods
func is_living(pokemon : Pokemon) -> bool:
	if !pokemon.health: return true #awaiting for existence
	return pokemon.health.living

func go_main() -> void:
	@warning_ignore("return_value_discarded")
	get_tree().change_scene_to_file("res://scenes/main.tscn")
#endregion
