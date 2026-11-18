class_name Types
extends Resource

@export var data : Array[TypesUtil.POKEMON_TYPE]

func get_attack_multiplier(defender_types : Types) -> float:
	return TypesUtil.get_stacked_multiplier(data, defender_types.data)

func get_defense_multiplier(attacker_types : Types) -> float:
	return TypesUtil.get_stacked_multiplier(attacker_types.data, data)
