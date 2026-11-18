extends Node2D

var bulbasaur_scene : PackedScene = preload("res://resources/pokemon/Bulbasaur/Bulbasaur.tscn")
var DD_scene : PackedScene = preload("res://resources/pokemon/DD/DD.tscn")

func _ready() -> void:
	if Global.player_won != Global.WINNING_STATE.MainMenu:
		print("game done!")
		match Global.player_won:
			Global.WINNING_STATE.Win:
				print("won!!")
			Global.WINNING_STATE.Lose:
				print("lost!!!")
			Global.WINNING_STATE.Draw:
				print("drew!!!")
			Global.WINNING_STATE.RanAway:
				print("ranaway")
			_:
				print("unsure what happened")
	
	var opponents : Dictionary[Battle.BATTLE_POSITIONS, Pokemon] = {
		Battle.BATTLE_POSITIONS.Middle : DD_scene.instantiate(),
	}
	var player : Dictionary[Battle.BATTLE_POSITIONS, Pokemon] = {
		Battle.BATTLE_POSITIONS.Middle : bulbasaur_scene.instantiate(),
	}

	Global.setup(player, opponents)
	call_deferred("go_battle_sequence")

func go_battle_sequence() -> void:
	@warning_ignore("return_value_discarded")
	get_tree().change_scene_to_file("res://scenes/BattleSequence.tscn")
