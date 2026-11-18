@abstract
class_name Moves
extends Resource

@export var name : String
@export var description : String

@abstract
func apply_ability(owner : Pokemon, allies : Battle, opponents : Battle) -> void
