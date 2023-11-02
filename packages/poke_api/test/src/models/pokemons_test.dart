import 'dart:convert' show jsonEncode;

import 'package:poke_api/src/models/pokemons.dart';
import 'package:test/test.dart';

void main() {
  const count = 1292;
  const next = 'https://pokeapi.co/api/v2/pokemon/?offset=6&limit=3';
  const previous = 'https://pokeapi.co/api/v2/pokemon/?offset=0&limit=3';
  const pokemon01 = 'charmander';
  const url01 = 'https://pokeapi.co/api/v2/pokemon/4/';
  const pokemon02 = 'charmeleon';
  const url02 = 'https://pokeapi.co/api/v2/pokemon/5/';
  const pokemon03 = 'charizard';
  const url03 = 'https://pokeapi.co/api/v2/pokemon/6/';
  const pokemonsMap = <String, dynamic>{
    'count': count,
    'next': next,
    'previous': previous,
    'results': [
      {'name': pokemon01, 'url': url01},
      {'name': pokemon02, 'url': url02},
      {'name': pokemon03, 'url': url03},
    ],
  };

  test('Test the default initializer', () {
    final pokemons01 = Pokemons(
      count: count,
      next: next,
      previous: previous,
      pokemons: [
        PokemonAddress(name: pokemon01, url: url01),
        PokemonAddress(name: pokemon02, url: url02),
        PokemonAddress(name: pokemon03, url: url03),
      ],
    );

    expect(pokemons01.count, count);
    expect(pokemons01.next, next);
    expect(pokemons01.previous, previous);
    expect(pokemons01.pokemons.length, 3);
    expect(pokemons01.pokemons[0], PokemonAddress(name: pokemon01, url: url01));
    expect(pokemons01.pokemons[1], PokemonAddress(name: pokemon02, url: url02));
    expect(pokemons01.pokemons[2], PokemonAddress(name: pokemon03, url: url03));
  });

  test('Test initialize from a map', () {
    final pokemons01 = Pokemons(
      count: count,
      next: next,
      previous: previous,
      pokemons: [
        PokemonAddress(name: pokemon01, url: url01),
        PokemonAddress(name: pokemon02, url: url02),
        PokemonAddress(name: pokemon03, url: url03),
      ],
    );
    final pokemons02 = Pokemons.fromMap(pokemonsMap);

    expect(pokemons01, equals(pokemons02));
  });

  test('Test initialize from a json', () {
    final pokemons01 = Pokemons(
      count: count,
      next: next,
      previous: previous,
      pokemons: [
        PokemonAddress(name: pokemon01, url: url01),
        PokemonAddress(name: pokemon02, url: url02),
        PokemonAddress(name: pokemon03, url: url03),
      ],
    );
    final pokemons02 = Pokemons.fromJson(jsonEncode(pokemonsMap));

    expect(pokemons01, equals(pokemons02));
  });
}
