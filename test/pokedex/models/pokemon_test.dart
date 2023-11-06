import 'dart:convert';

import 'package:flutter_pokedex/pokedex/models/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_repository/pokedex_repository.dart'
    as pokedex_repository;

import '../../helpers/helpers.dart';

void main() {
  group('Test initializer', () {
    test('default', () {
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
        favorite: false,
      );

      expect(
        pokemon01,
        isA<Pokemon>()
            .having((pokemon) => pokemon.id, 'id', 1)
            .having((pokemon) => pokemon.name, 'name', 'Bulbasaur')
            .having(
              (pokemon) => pokemon.types[0],
              'types[0]',
              PokemonType.grass,
            )
            .having(
              (pokemon) => pokemon.types[1],
              'types[1]',
              PokemonType.poison,
            )
            .having((pokemon) => pokemon.height, 'height', 7)
            .having((pokemon) => pokemon.weight, 'weight', 69)
            .having((pokemon) => pokemon.hp, 'hp', 45)
            .having((pokemon) => pokemon.attack, 'attack', 49)
            .having((pokemon) => pokemon.defense, 'defense', 49)
            .having((pokemon) => pokemon.specialAttack, 'specialAttack', 65)
            .having((pokemon) => pokemon.specialDefense, 'specialDefense', 65)
            .having((pokemon) => pokemon.speed, 'speed', 45)
            .having(
              (pokemon) => pokemon.icon,
              'icon',
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
            )
            .having(
              (pokemon) => pokemon.sprite,
              'sprite',
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
            )
            .having((pokemon) => pokemon.favorite, 'favorite', false),
      );
    });

    test('from json', () {
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
      final pokemon02 = Pokemon.fromJson(jsonEncode(pokemonMap));

      expect(pokemon01, pokemon02);
    });

    test('from map', () {
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
      final pokemon02 = Pokemon.fromMap(pokemonMap);

      expect(pokemon01, pokemon02);
    });
  });

  test('Test toMap', () {
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

    expect(pokemon01.toMap(), pokemonMap);
  });

  group('Test copyWith', () {
    test('copy id', () {
      final pokemon = pokemon02.copyWith(id: 30);

      expect(pokemon.id, 30);
      expect(pokemon.name, 'Charmander');
      expect(pokemon.types, [PokemonType.fire]);
      expect(pokemon.height, 6);
      expect(pokemon.weight, 85);
      expect(pokemon.hp, 39);
      expect(pokemon.attack, 52);
      expect(pokemon.defense, 43);
      expect(pokemon.specialAttack, 60);
      expect(pokemon.specialDefense, 50);
      expect(pokemon.speed, 65);
      expect(
        pokemon.icon,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png',
      );
      expect(
        pokemon.sprite,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png',
      );
      expect(pokemon.favorite, true);
    });

    test('copy name', () {
      final pokemon = pokemon02.copyWith(name: 'Nidorina');

      expect(pokemon.id, 4);
      expect(pokemon.name, 'Nidorina');
      expect(pokemon.types, [PokemonType.fire]);
      expect(pokemon.height, 6);
      expect(pokemon.weight, 85);
      expect(pokemon.hp, 39);
      expect(pokemon.attack, 52);
      expect(pokemon.defense, 43);
      expect(pokemon.specialAttack, 60);
      expect(pokemon.specialDefense, 50);
      expect(pokemon.speed, 65);
      expect(
        pokemon.icon,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png',
      );
      expect(
        pokemon.sprite,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png',
      );
      expect(pokemon.favorite, true);
    });

    test('copy types', () {
      final pokemon = pokemon02.copyWith(types: [PokemonType.poison]);

      expect(pokemon.id, 4);
      expect(pokemon.name, 'Charmander');
      expect(pokemon.types, [PokemonType.poison]);
      expect(pokemon.height, 6);
      expect(pokemon.weight, 85);
      expect(pokemon.hp, 39);
      expect(pokemon.attack, 52);
      expect(pokemon.defense, 43);
      expect(pokemon.specialAttack, 60);
      expect(pokemon.specialDefense, 50);
      expect(pokemon.speed, 65);
      expect(
        pokemon.icon,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png',
      );
      expect(
        pokemon.sprite,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png',
      );
      expect(pokemon.favorite, true);
    });

    test('copy height', () {
      final pokemon = pokemon02.copyWith(height: 8);

      expect(pokemon.id, 4);
      expect(pokemon.name, 'Charmander');
      expect(pokemon.types, [PokemonType.fire]);
      expect(pokemon.height, 8);
      expect(pokemon.weight, 85);
      expect(pokemon.hp, 39);
      expect(pokemon.attack, 52);
      expect(pokemon.defense, 43);
      expect(pokemon.specialAttack, 60);
      expect(pokemon.specialDefense, 50);
      expect(pokemon.speed, 65);
      expect(
        pokemon.icon,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png',
      );
      expect(
        pokemon.sprite,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png',
      );
      expect(pokemon.favorite, true);
    });

    test('copy weight', () {
      final pokemon = pokemon02.copyWith(weight: 200);

      expect(pokemon.id, 4);
      expect(pokemon.name, 'Charmander');
      expect(pokemon.types, [PokemonType.fire]);
      expect(pokemon.height, 6);
      expect(pokemon.weight, 200);
      expect(pokemon.hp, 39);
      expect(pokemon.attack, 52);
      expect(pokemon.defense, 43);
      expect(pokemon.specialAttack, 60);
      expect(pokemon.specialDefense, 50);
      expect(pokemon.speed, 65);
      expect(
        pokemon.icon,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png',
      );
      expect(
        pokemon.sprite,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png',
      );
      expect(pokemon.favorite, true);
    });

    test('copy hp', () {
      final pokemon = pokemon02.copyWith(hp: 70);

      expect(pokemon.id, 4);
      expect(pokemon.name, 'Charmander');
      expect(pokemon.types, [PokemonType.fire]);
      expect(pokemon.height, 6);
      expect(pokemon.weight, 85);
      expect(pokemon.hp, 70);
      expect(pokemon.attack, 52);
      expect(pokemon.defense, 43);
      expect(pokemon.specialAttack, 60);
      expect(pokemon.specialDefense, 50);
      expect(pokemon.speed, 65);
      expect(
        pokemon.icon,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png',
      );
      expect(
        pokemon.sprite,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png',
      );
      expect(pokemon.favorite, true);
    });

    test('copy attack', () {
      final pokemon = pokemon02.copyWith(attack: 62);

      expect(pokemon.id, 4);
      expect(pokemon.name, 'Charmander');
      expect(pokemon.types, [PokemonType.fire]);
      expect(pokemon.height, 6);
      expect(pokemon.weight, 85);
      expect(pokemon.hp, 39);
      expect(pokemon.attack, 62);
      expect(pokemon.defense, 43);
      expect(pokemon.specialAttack, 60);
      expect(pokemon.specialDefense, 50);
      expect(pokemon.speed, 65);
      expect(
        pokemon.icon,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png',
      );
      expect(
        pokemon.sprite,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png',
      );
      expect(pokemon.favorite, true);
    });

    test('copy defense', () {
      final pokemon = pokemon02.copyWith(defense: 67);

      expect(pokemon.id, 4);
      expect(pokemon.name, 'Charmander');
      expect(pokemon.types, [PokemonType.fire]);
      expect(pokemon.height, 6);
      expect(pokemon.weight, 85);
      expect(pokemon.hp, 39);
      expect(pokemon.attack, 52);
      expect(pokemon.defense, 67);
      expect(pokemon.specialAttack, 60);
      expect(pokemon.specialDefense, 50);
      expect(pokemon.speed, 65);
      expect(
        pokemon.icon,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png',
      );
      expect(
        pokemon.sprite,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png',
      );
      expect(pokemon.favorite, true);
    });

    test('copy specialAttack', () {
      final pokemon = pokemon02.copyWith(specialAttack: 55);

      expect(pokemon.id, 4);
      expect(pokemon.name, 'Charmander');
      expect(pokemon.types, [PokemonType.fire]);
      expect(pokemon.height, 6);
      expect(pokemon.weight, 85);
      expect(pokemon.hp, 39);
      expect(pokemon.attack, 52);
      expect(pokemon.defense, 43);
      expect(pokemon.specialAttack, 55);
      expect(pokemon.specialDefense, 50);
      expect(pokemon.speed, 65);
      expect(
        pokemon.icon,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png',
      );
      expect(
        pokemon.sprite,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png',
      );
      expect(pokemon.favorite, true);
    });

    test('copy specialDefense', () {
      final pokemon = pokemon02.copyWith(specialDefense: 55);

      expect(pokemon.id, 4);
      expect(pokemon.name, 'Charmander');
      expect(pokemon.types, [PokemonType.fire]);
      expect(pokemon.height, 6);
      expect(pokemon.weight, 85);
      expect(pokemon.hp, 39);
      expect(pokemon.attack, 52);
      expect(pokemon.defense, 43);
      expect(pokemon.specialAttack, 60);
      expect(pokemon.specialDefense, 55);
      expect(pokemon.speed, 65);
      expect(
        pokemon.icon,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png',
      );
      expect(
        pokemon.sprite,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png',
      );
      expect(pokemon.favorite, true);
    });

    test('copy speed', () {
      final pokemon = pokemon02.copyWith(speed: 56);

      expect(pokemon.id, 4);
      expect(pokemon.name, 'Charmander');
      expect(pokemon.types, [PokemonType.fire]);
      expect(pokemon.height, 6);
      expect(pokemon.weight, 85);
      expect(pokemon.hp, 39);
      expect(pokemon.attack, 52);
      expect(pokemon.defense, 43);
      expect(pokemon.specialAttack, 60);
      expect(pokemon.specialDefense, 50);
      expect(pokemon.speed, 56);
      expect(
        pokemon.icon,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png',
      );
      expect(
        pokemon.sprite,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png',
      );
      expect(pokemon.favorite, true);
    });

    test('copy icon', () {
      final pokemon = pokemon02.copyWith(
        icon:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/30.png',
      );

      expect(pokemon.id, 4);
      expect(pokemon.name, 'Charmander');
      expect(pokemon.types, [PokemonType.fire]);
      expect(pokemon.height, 6);
      expect(pokemon.weight, 85);
      expect(pokemon.hp, 39);
      expect(pokemon.attack, 52);
      expect(pokemon.defense, 43);
      expect(pokemon.specialAttack, 60);
      expect(pokemon.specialDefense, 50);
      expect(pokemon.speed, 65);
      expect(
        pokemon.icon,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/30.png',
      );
      expect(
        pokemon.sprite,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png',
      );
      expect(pokemon.favorite, true);
    });

    test('copy sprite', () {
      final pokemon = pokemon02.copyWith(
        sprite:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/30.png',
      );

      expect(pokemon.id, 4);
      expect(pokemon.name, 'Charmander');
      expect(pokemon.types, [PokemonType.fire]);
      expect(pokemon.height, 6);
      expect(pokemon.weight, 85);
      expect(pokemon.hp, 39);
      expect(pokemon.attack, 52);
      expect(pokemon.defense, 43);
      expect(pokemon.specialAttack, 60);
      expect(pokemon.specialDefense, 50);
      expect(pokemon.speed, 65);
      expect(
        pokemon.icon,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png',
      );
      expect(
        pokemon.sprite,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/30.png',
      );
      expect(pokemon.favorite, true);
    });

    test('copy favorite', () {
      final pokemon = pokemon02.copyWith(favorite: false);

      expect(pokemon.id, 4);
      expect(pokemon.name, 'Charmander');
      expect(pokemon.types, [PokemonType.fire]);
      expect(pokemon.height, 6);
      expect(pokemon.weight, 85);
      expect(pokemon.hp, 39);
      expect(pokemon.attack, 52);
      expect(pokemon.defense, 43);
      expect(pokemon.specialAttack, 60);
      expect(pokemon.specialDefense, 50);
      expect(pokemon.speed, 65);
      expect(
        pokemon.icon,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png',
      );
      expect(
        pokemon.sprite,
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png',
      );
      expect(pokemon.favorite, false);
    });
  });

  group('Test get type from repository', () {
    test('PokemonType.normal', () {
      final type = Pokemon.getTypeFromRepository(
        pokedex_repository.PokemonType.normal,
      );

      expect(type, PokemonType.normal);
    });

    test('PokemonType.fighting', () {
      final type = Pokemon.getTypeFromRepository(
        pokedex_repository.PokemonType.fighting,
      );

      expect(type, PokemonType.fighting);
    });

    test('PokemonType.flying', () {
      final type = Pokemon.getTypeFromRepository(
        pokedex_repository.PokemonType.flying,
      );

      expect(type, PokemonType.flying);
    });

    test('PokemonType.poison', () {
      final type = Pokemon.getTypeFromRepository(
        pokedex_repository.PokemonType.poison,
      );

      expect(type, PokemonType.poison);
    });

    test('PokemonType.ground', () {
      final type = Pokemon.getTypeFromRepository(
        pokedex_repository.PokemonType.ground,
      );

      expect(type, PokemonType.ground);
    });

    test('PokemonType.rock', () {
      final type = Pokemon.getTypeFromRepository(
        pokedex_repository.PokemonType.rock,
      );

      expect(type, PokemonType.rock);
    });

    test('PokemonType.bug', () {
      final type = Pokemon.getTypeFromRepository(
        pokedex_repository.PokemonType.bug,
      );

      expect(type, PokemonType.bug);
    });

    test('PokemonType.ghost', () {
      final type = Pokemon.getTypeFromRepository(
        pokedex_repository.PokemonType.ghost,
      );

      expect(type, PokemonType.ghost);
    });

    test('PokemonType.steel', () {
      final type = Pokemon.getTypeFromRepository(
        pokedex_repository.PokemonType.steel,
      );

      expect(type, PokemonType.steel);
    });

    test('PokemonType.fire', () {
      final type = Pokemon.getTypeFromRepository(
        pokedex_repository.PokemonType.fire,
      );

      expect(type, PokemonType.fire);
    });

    test('PokemonType.water', () {
      final type = Pokemon.getTypeFromRepository(
        pokedex_repository.PokemonType.water,
      );

      expect(type, PokemonType.water);
    });

    test('PokemonType.grass', () {
      final type = Pokemon.getTypeFromRepository(
        pokedex_repository.PokemonType.grass,
      );

      expect(type, PokemonType.grass);
    });

    test('PokemonType.electric', () {
      final type = Pokemon.getTypeFromRepository(
        pokedex_repository.PokemonType.electric,
      );

      expect(type, PokemonType.electric);
    });

    test('PokemonType.psychic', () {
      final type = Pokemon.getTypeFromRepository(
        pokedex_repository.PokemonType.psychic,
      );

      expect(type, PokemonType.psychic);
    });

    test('PokemonType.ice', () {
      final type = Pokemon.getTypeFromRepository(
        pokedex_repository.PokemonType.ice,
      );

      expect(type, PokemonType.ice);
    });

    test('PokemonType.dragon', () {
      final type = Pokemon.getTypeFromRepository(
        pokedex_repository.PokemonType.dragon,
      );

      expect(type, PokemonType.dragon);
    });

    test('PokemonType.dark', () {
      final type = Pokemon.getTypeFromRepository(
        pokedex_repository.PokemonType.dark,
      );

      expect(type, PokemonType.dark);
    });

    test('PokemonType.fairy', () {
      final type = Pokemon.getTypeFromRepository(
        pokedex_repository.PokemonType.fairy,
      );

      expect(type, PokemonType.fairy);
    });

    test('PokemonType.unknown', () {
      final type = Pokemon.getTypeFromRepository(
        pokedex_repository.PokemonType.unknown,
      );

      expect(type, PokemonType.unknown);
    });

    test('PokemonType.shadow', () {
      final type = Pokemon.getTypeFromRepository(
        pokedex_repository.PokemonType.shadow,
      );

      expect(type, PokemonType.shadow);
    });
  });
}
