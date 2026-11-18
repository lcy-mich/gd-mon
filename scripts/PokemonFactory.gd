class_name PokemonFactory

func create( 
		pokemon_resource : PokemonResource, 
		abilities : Array[Moves], 
		texture : AnimatingSprite2D, 
		front : AnimatingSprite2D,
		back : AnimatingSprite2D,
	) -> Pokemon:
	
	var pokemon : Pokemon = Pokemon.new()
	
	pokemon.pokemon_resource = pokemon_resource
	pokemon.abilities = abilities.duplicate_deep()
	pokemon.texture = texture
	pokemon.front = front
	pokemon.back = back
	pokemon.add_child(texture)
	pokemon.add_child(front)
	pokemon.add_child(back)
	
	return pokemon
