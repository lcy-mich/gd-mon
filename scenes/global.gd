#region Boilerplate
extends Node

enum WINNING_STATE {
	Win,
	Lose,
	Draw, #how??
	RanAway,
	MainMenu
}
#endregion

#region Data
var player_pokemons : Dictionary[Battle.BATTLE_POSITIONS, Pokemon]
var opponent_pokemons : Dictionary[Battle.BATTLE_POSITIONS, Pokemon]
var player_won : WINNING_STATE = WINNING_STATE.MainMenu
#endregion

func clean_data() -> void:
	player_pokemons = {}
	opponent_pokemons = {}
	player_won = WINNING_STATE.MainMenu
	
func setup(
	plr_pokemons : Dictionary[Battle.BATTLE_POSITIONS, Pokemon], 
	opp_pokemons : Dictionary[Battle.BATTLE_POSITIONS, Pokemon],
	) -> void:
	clean_data()
	player_pokemons = plr_pokemons
	opponent_pokemons = opp_pokemons

func win() -> void:
	clean_data()
	player_won = WINNING_STATE.Win
	
func lose() -> void:
	clean_data()
	player_won = WINNING_STATE.Lose
	
func draw() -> void:
	clean_data()
	player_won = WINNING_STATE.Draw
