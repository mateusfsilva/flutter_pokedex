import 'dart:convert';

import 'package:flutter_pokedex/pokedex/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('Test initializers', () {
    test('default', () {
      expect(
        pokedex01,
        isA<Pokedex>()
            .having((p) => p.orderBy, 'orderBy', PokedexOrder.id)
            .having((p) => p.completed, 'completed', false)
            .having((p) => p.pokemons, 'pokemons', [pokemon01]),
      );
    });

    test('from a json', () {
      final pokedex02 = Pokedex.fromJson(jsonEncode(pokedexMap));

      expect(pokedex01, pokedex02);
    });

    test('from a map', () {
      final pokedex02 = Pokedex.fromMap(pokedexMap);

      expect(pokedex01, pokedex02);
    });
  });

  test('Test toMap', () {
    expect(pokedex01.toMap(), pokedexMap);
  });

  group('copyWith', () {
    test('orderBy', () {
      final pokedex02 = pokedex01.copyWith(orderBy: PokedexOrder.favorites);

      expect(pokedex02.orderBy, PokedexOrder.favorites);
      expect(pokedex02.completed, false);
      expect(pokedex02.pokemons, [pokemon01]);
    });

    test('completed', () {
      final pokedex02 = pokedex01.copyWith(completed: true);

      expect(pokedex02.orderBy, PokedexOrder.id);
      expect(pokedex02.completed, true);
      expect(pokedex02.pokemons, [pokemon01]);
    });

    test('pokemons', () {
      final pokedex02 = pokedex01.copyWith(pokemons: <Pokemon>[]);

      expect(pokedex02.orderBy, PokedexOrder.id);
      expect(pokedex02.completed, false);
      expect(pokedex02.pokemons, <Pokemon>[]);
    });
  });
}
