class_name TypesUtil

enum POKEMON_TYPE {
	Normal,
	Fire,
	Water,
	Electric,
	Grass,
	Ice,
	Fighting,
	Poison,
	Ground,
	Flying,
	Psychic,
	Bug,
	Rock,
	Ghost,
	Dragon,
	Dark,
	Steel,
	Fairy
}

const _type_to_str : Dictionary[POKEMON_TYPE, String] = {
	POKEMON_TYPE.Normal : "Normal",
	POKEMON_TYPE.Fire : "Fire",
	POKEMON_TYPE.Water : "Water",
	POKEMON_TYPE.Electric : "Electric",
	POKEMON_TYPE.Grass : "Grass",
	POKEMON_TYPE.Ice : "Ice",
	POKEMON_TYPE.Fighting : "Fighting",
	POKEMON_TYPE.Poison : "Poison",
	POKEMON_TYPE.Ground : "Ground",
	POKEMON_TYPE.Flying : "Flying",
	POKEMON_TYPE.Psychic : "Psychic",
	POKEMON_TYPE.Bug : "Bug",
	POKEMON_TYPE.Rock : "Rock",
	POKEMON_TYPE.Ghost : "Ghost",
	POKEMON_TYPE.Dragon : "Dragon",
	POKEMON_TYPE.Dark : "Dark",
	POKEMON_TYPE.Steel : "Steel",
	POKEMON_TYPE.Fairy : "Fairy",
}

static var is_setup : bool = false
static var types : CSVReader
static func setup() -> void:
	if is_setup:
		return
	types = CSVReader.new("res://script/Types/types_chart.csv")
	is_setup = true

static func get_effect_multiplier(attacker : POKEMON_TYPE, defender : POKEMON_TYPE) -> float:
	if !is_setup:
		setup()
	
	var raw_mult : String = types.get_element_from_row_column(_type_to_str[attacker], _type_to_str[defender])
	var mult : float
	if raw_mult == "":
		mult = 1.0
	else:
		if !raw_mult.is_valid_float():
			push_error(raw_mult, " is not a valid float")
		mult = float(raw_mult)
		
	return mult

static func get_stacked_multiplier(attacker_types : Array[POKEMON_TYPE], defender_types : Array[POKEMON_TYPE]) -> float:
	var final_mult : float = 0.0
	for attacker_type : POKEMON_TYPE in attacker_types:
		for defender_type : POKEMON_TYPE in defender_types:
			final_mult *= get_effect_multiplier(attacker_type, defender_type)
	return final_mult
