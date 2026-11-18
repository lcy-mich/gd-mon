class_name PokemonResource
extends Resource

@export var pokedata : PokeData
@export var stats : Stats
@export var types : Types

static var number : int = 0

func _init() -> void:
	number += 1
