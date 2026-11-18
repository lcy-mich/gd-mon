class_name Pokemon
extends Node2D

#region Constants
enum TEXTURE_STATE {
	Texture,
	Front,
	Back
}
#endregion

#region Exports
@export var pokemon_resource : PokemonResource
@export var abilities : Array[Moves]
@export var texture : AnimatingSprite2D
@export var front : AnimatingSprite2D
@export var back : AnimatingSprite2D
@export var texture_state : TEXTURE_STATE:
	set(value):
		texture_state = value
		if !texture: return
		texture_state_change()
#endregion

#region Variables
var health_component : Health
var stats : Stats
var data : PokeData
#endregion

func _ready() -> void:
	health_component = Health.new(pokemon_resource.stats.hp)
	stats = pokemon_resource.stats.duplicate_deep()
	data = pokemon_resource.pokedata.duplicate_deep()
	
	@warning_ignore("return_value_discarded")
	health_component.connect("died", pokemon_died)
	texture_state_change()

#region Methods
func is_fully_loaded() -> bool:
	return is_node_ready() and health_component and stats and data

func pokemon_died(_attacker : Variant) -> void:
	print("pokemon died :<")
	hide()
	
func texture_state_change() -> void:
	if texture:
		texture.visible = texture_state == TEXTURE_STATE.Texture
	if front:
		front.visible = texture_state == TEXTURE_STATE.Front
	if back:
		back.visible = texture_state == TEXTURE_STATE.Back
	
#endregion

	
