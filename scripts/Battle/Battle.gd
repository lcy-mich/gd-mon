class_name Battle
extends Node2D

enum BATTLE_POSITIONS {
	Left = 1,
	Middle = 2,
	Right = 3
}

#region Exports
@export var pokemons : Dictionary[BATTLE_POSITIONS, Pokemon]
@export var is_opponent : bool = false
#endregion

func _process(_delta: float) -> void:
	for battle_pos : BATTLE_POSITIONS in pokemons:
		var pokemon : Pokemon = pokemons[battle_pos]
		var pos_marker : Marker2D = get_node(str(battle_pos))
		
		pokemon.position = pos_marker.position
		pokemon.rotation = pos_marker.rotation
		
		pokemon.texture_state = Pokemon.TEXTURE_STATE.Front if is_opponent else Pokemon.TEXTURE_STATE.Back
		
		if pokemon.get_parent():
			pokemon.reparent($Pokemons)
		else:
			$Pokemons.add_child(pokemon)
