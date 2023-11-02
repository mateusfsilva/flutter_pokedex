import 'dart:convert' show jsonEncode;

import 'package:poke_api/src/models/pokemon.dart';
import 'package:test/test.dart';

void main() {
  const id = 1;
  const name = 'bulbasaur';
  const type01 = 'grass';
  const type02 = 'poison';
  const height = 7;
  const weight = 69;
  const hp = 45;
  const attack = 49;
  const defense = 49;
  const specialAttack = 65;
  const specialDefense = 65;
  const speed = 45;
  const sprite =
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png';
  const pokemonMap = <String, dynamic>{
    'abilities': [],
    'base_experience': 64,
    'forms': [],
    'game_indices': [],
    'height': height,
    'held_items': [],
    'id': id,
    'is_default': true,
    'location_area_encounters':
        'https://pokeapi.co/api/v2/pokemon/1/encounters',
    'moves': [],
    'name': name,
    'order': 1,
    'past_abilities': [],
    'past_types': [],
    'species': {},
    'sprites': {
      'back_default':
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/1.png',
      'back_female': null,
      'back_shiny':
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/1.png',
      'back_shiny_female': null,
      'front_default':
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
      'front_female': null,
      'front_shiny':
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png',
      'front_shiny_female': null,
      'other': {
        'dream_world': {
          'front_default':
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/1.svg',
          'front_female': null,
        },
        'home': {
          'front_default':
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png',
          'front_female': null,
          'front_shiny':
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/shiny/1.png',
          'front_shiny_female': null,
        },
        'official-artwork': {
          'front_default': sprite,
          'front_shiny':
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/1.png',
        },
      },
      'versions': {},
    },
    'stats': [
      {
        'base_stat': hp,
        'effort': 0,
        'stat': {'name': 'hp', 'url': 'https://pokeapi.co/api/v2/stat/1/'},
      },
      {
        'base_stat': attack,
        'effort': 0,
        'stat': {'name': 'attack', 'url': 'https://pokeapi.co/api/v2/stat/2/'},
      },
      {
        'base_stat': defense,
        'effort': 0,
        'stat': {'name': 'defense', 'url': 'https://pokeapi.co/api/v2/stat/3/'},
      },
      {
        'base_stat': specialAttack,
        'effort': 1,
        'stat': {
          'name': 'special-attack',
          'url': 'https://pokeapi.co/api/v2/stat/4/',
        },
      },
      {
        'base_stat': specialDefense,
        'effort': 0,
        'stat': {
          'name': 'special-defense',
          'url': 'https://pokeapi.co/api/v2/stat/5/',
        },
      },
      {
        'base_stat': speed,
        'effort': 0,
        'stat': {'name': 'speed', 'url': 'https://pokeapi.co/api/v2/stat/6/'},
      }
    ],
    'types': [
      {
        'slot': 1,
        'type': {'name': type01, 'url': 'https://pokeapi.co/api/v2/type/12/'},
      },
      {
        'slot': 2,
        'type': {'name': type02, 'url': 'https://pokeapi.co/api/v2/type/4/'},
      }
    ],
    'weight': weight,
  };

  test('Test the default initializer', () {
    final pokemon01 = Pokemon(
      id: id,
      name: name,
      types: [
        PokemonType.fromValue(type01),
        PokemonType.fromValue(type02),
      ],
      height: height,
      weight: weight,
      hp: hp,
      attack: attack,
      defense: defense,
      specialAttack: specialAttack,
      specialDefense: specialDefense,
      speed: speed,
      sprite: sprite,
    );

    expect(pokemon01.id, id);
    expect(pokemon01.name, name);
    expect(pokemon01.types.length, 2);
    expect(pokemon01.types[0].value, type01);
    expect(pokemon01.types[1].value, type02);
    expect(pokemon01.height, height);
    expect(pokemon01.weight, weight);
    expect(pokemon01.hp, hp);
    expect(pokemon01.attack, attack);
    expect(pokemon01.defense, defense);
    expect(pokemon01.specialAttack, specialAttack);
    expect(pokemon01.specialDefense, specialDefense);
    expect(pokemon01.speed, speed);
    expect(pokemon01.sprite, sprite);
  });

  test('Test initialize from a map', () {
    final pokemon01 = Pokemon(
      id: id,
      name: name,
      types: [
        PokemonType.fromValue(type01),
        PokemonType.fromValue(type02),
      ],
      height: height,
      weight: weight,
      hp: hp,
      attack: attack,
      defense: defense,
      specialAttack: specialAttack,
      specialDefense: specialDefense,
      speed: speed,
      sprite: sprite,
    );
    final pokemon02 = Pokemon.fromMap(pokemonMap);

    expect(pokemon01, equals(pokemon02));
  });

  test('Test initialize from a json', () {
    final pokemon01 = Pokemon(
      id: id,
      name: name,
      types: [
        PokemonType.fromValue(type01),
        PokemonType.fromValue(type02),
      ],
      height: height,
      weight: weight,
      hp: hp,
      attack: attack,
      defense: defense,
      specialAttack: specialAttack,
      specialDefense: specialDefense,
      speed: speed,
      sprite: sprite,
    );
    final pokemon02 = Pokemon.fromJson(jsonEncode(pokemonMap));

    expect(pokemon01, equals(pokemon02));
  });

  test('Test an invalid pokemon type', () {
    final pokemonType = PokemonType.fromValue('invalid-type');

    expect(pokemonType, equals(PokemonType.unknown));
  });
}
