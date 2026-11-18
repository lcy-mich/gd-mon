class_name PokemonResource
extends Resource

@export var base_pokedata : PokeData
@export var base_stats : Stats
@export var types : Types

static var number : int = 0

func _init() -> void:
	number += 1
