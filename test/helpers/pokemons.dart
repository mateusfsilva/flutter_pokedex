import 'package:flutter_pokedex/pokedex/models/models.dart';

final pokedex01 = Pokedex(
  orderBy: PokedexOrder.id,
  completed: false,
  pokemons: [pokemon01],
);
final pokedexMap = <String, dynamic>{
  'order_by': 0,
  'completed': false,
  'pokemons': [
    pokemonMap,
  ],
};

final pokemon01 = Pokemon(
  id: 1,
  name: 'Bulbasaur',
  types: [
    PokemonType.grass,
    PokemonType.poison,
  ],
  height: 7,
  weight: 69,
  hp: 45,
  attack: 49,
  defense: 49,
  specialAttack: 65,
  specialDefense: 65,
  speed: 45,
  icon:
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
  sprite:
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
  favorite: true,
);

final pokemon02 = Pokemon(
  id: 4,
  name: 'Charmander',
  types: [
    PokemonType.fire,
  ],
  height: 6,
  weight: 85,
  hp: 39,
  attack: 52,
  defense: 43,
  specialAttack: 60,
  specialDefense: 50,
  speed: 65,
  icon:
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png',
  sprite:
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png',
  favorite: true,
);

const pokemonMap = <String, dynamic>{
  'id': 1,
  'name': 'Bulbasaur',
  'types': [11, 3],
  'height': 7,
  'weight': 69,
  'hp': 45,
  'attack': 49,
  'defense': 49,
  'special_attack': 65,
  'special_defense': 65,
  'speed': 45,
  'icon':
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
  'sprite':
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
  'favorite': true,
};
