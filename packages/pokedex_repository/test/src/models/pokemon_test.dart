import 'dart:convert' show jsonEncode;

import 'package:pokedex_repository/pokedex_repository.dart';
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
  const icon =
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png';
  const sprite =
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png';
  const pokemonMap = <String, dynamic>{
    'height': height,
    'id': id,
    'name': name,
    'sprite': sprite,
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
    'icon': icon,
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
      icon: icon,
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
    expect(pokemon01.icon, icon);
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
      icon: icon,
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
      icon: icon,
      sprite: sprite,
    );
    final pokemon02 = Pokemon.fromJson(jsonEncode(pokemonMap));

    expect(pokemon01, equals(pokemon02));
  });

  test('Test toMap', () {
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
      icon: icon,
      sprite: sprite,
    );

    expect(pokemon01.toMap(), pokemonMap);
  });

  test('Test an invalid pokemon type', () {
    final pokemonType = PokemonType.fromValue('invalid-type');

    expect(pokemonType, equals(PokemonType.unknown));
  });
}
