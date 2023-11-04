import 'dart:convert' show jsonEncode;

import 'package:pokedex_repository/pokedex_repository.dart';
import 'package:test/test.dart';

void main() {
  const total = 1292;
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
  const icon =
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png';
  const sprite =
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png';
  const pokemonMap = <String, dynamic>{
    'height': height,
    'id': id,
    'name': name,
    'sprite': sprite,
    'icon': icon,
    'hp': hp,
    'attack': attack,
    'defense': defense,
    'special_attack': specialAttack,
    'special_defense': specialDefense,
    'speed': speed,
    'types': [
      type01,
      type02,
    ],
    'weight': weight,
  };
  const pokedexMap = <String, dynamic>{
    'total': total,
    'pokemons': [
      pokemonMap,
    ],
  };
  final pokemon01 = Pokemon.fromMap(pokemonMap);

  test('Test the default initializer', () {
    final pokedex01 = Pokedex(
      total: total,
      pokemons: [pokemon01],
    );

    expect(pokedex01.total, total);
    expect(pokedex01.pokemons[0], pokemon01);
  });

  test('Test initialize from a map', () {
    final pokedex01 = Pokedex(
      total: total,
      pokemons: [pokemon01],
    );
    final pokedex02 = Pokedex.fromMap(pokedexMap);

    expect(pokedex01, equals(pokedex02));
  });

  test('Test initialize from a json', () {
    final pokedex01 = Pokedex(
      total: total,
      pokemons: [pokemon01],
    );
    final pokedex02 = Pokedex.fromJson(jsonEncode(pokedexMap));

    expect(pokedex01, equals(pokedex02));
  });

  test('Test toMap', () {
    final pokedex01 = Pokedex(
      total: total,
      pokemons: [pokemon01],
    );

    expect(pokedex01.toMap(), pokedexMap);
  });
}
