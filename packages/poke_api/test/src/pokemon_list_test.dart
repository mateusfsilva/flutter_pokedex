import 'dart:convert' show jsonEncode;

import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:poke_api/poke_api.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  late http.Client httpClient;
  late http.Response response;
  late PokeApiClient apiClient;

  setUpAll(() {
    registerFallbackValue(FakeUri());
  });

  setUp(() {
    httpClient = MockHttpClient();
    response = MockResponse();
    apiClient = PokeApiClient(httpClient: httpClient);

    when(() => httpClient.get(any())).thenAnswer((_) async => response);
  });

  group('Test pokemonsList', () {
    const offset = 6;
    const limit = 3;
    const count = 1292;
    const next = 'https://pokeapi.co/api/v2/pokemon/?offset=6&limit=3';
    const previous = 'https://pokeapi.co/api/v2/pokemon/?offset=0&limit=3';
    const pokemon01 = 'charmander';
    const url01 = 'https://pokeapi.co/api/v2/pokemon/4/';
    const pokemon02 = 'charmeleon';
    const url02 = 'https://pokeapi.co/api/v2/pokemon/5/';
    const pokemon03 = 'charizard';
    const url03 = 'https://pokeapi.co/api/v2/pokemon/6/';
    const results = [
      {'name': pokemon01, 'url': url01},
      {'name': pokemon02, 'url': url02},
      {'name': pokemon03, 'url': url03},
    ];
    const pokemonsMap = <String, dynamic>{
      'count': count,
      'next': next,
      'previous': previous,
      'results': results,
    };

    test('does not require an httpClient', () {
      expect(PokeApiClient(), isNotNull);
    });

    test('makes correct http request', () async {
      when(() => response.statusCode).thenReturn(200);
      when(() => response.body).thenReturn('{}');

      try {
        await apiClient.pokemonsList(
          offset: offset,
          limit: limit,
        );
      } catch (_) {}

      verify(
        () => httpClient.get(
          Uri.https(
            'pokeapi.co',
            '/api/v2/pokemon',
            {
              'offset': '$offset',
              'limit': '$limit',
            },
          ),
        ),
      ).called(1);
    });

    test('returns Pokemons on valid response', () async {
      when(() => response.statusCode).thenReturn(200);
      when(() => response.body).thenReturn(jsonEncode(pokemonsMap));

      final result = await apiClient.pokemonsList(
        offset: offset,
        limit: limit,
      );

      expect(
        result,
        isA<Pokemons>()
            .having((p) => p.count, 'count', count)
            .having((p) => p.next, 'next', next)
            .having((p) => p.previous, 'previous', previous)
            .having((p) => p.pokemons, 'pokemons', [
          PokemonAddress(name: pokemon01, url: url01),
          PokemonAddress(name: pokemon02, url: url02),
          PokemonAddress(name: pokemon03, url: url03),
        ]),
      );
    });

    test('throws PokemonsRequestFailure on non-200 response', () async {
      when(() => response.statusCode).thenReturn(400);

      expect(
        () async => apiClient.pokemonsList(
          offset: offset,
          limit: limit,
        ),
        throwsA(isA<PokemonsRequestFailure>()),
      );
    });

    test('throws PokemonsRequestNotFoundFailure on error response', () async {
      when(() => response.statusCode).thenReturn(200);
      when(() => response.body).thenReturn('{}');

      await expectLater(
        apiClient.pokemonsList(
          offset: offset,
          limit: limit,
        ),
        throwsA(isA<PokemonsNotFoundFailure>()),
      );
    });

    test('throws PokemonsRequestNotFoundFailure on empty response', () async {
      when(() => response.statusCode).thenReturn(200);
      when(() => response.body).thenReturn('{"results": []}');

      await expectLater(
        apiClient.pokemonsList(
          offset: offset,
          limit: limit,
        ),
        throwsA(isA<PokemonsNotFoundFailure>()),
      );
    });

    test('throws PokemonsRequestNotFoundFailure on no results', () async {
      when(() => response.statusCode).thenReturn(200);
      when(() => response.body).thenReturn(
        jsonEncode(
          <String, dynamic>{
            'count': count,
            'next': next,
            'previous': previous,
            'results': [],
          },
        ),
      );

      await expectLater(
        apiClient.pokemonsList(
          offset: offset,
          limit: limit,
        ),
        throwsA(isA<PokemonsNotFoundFailure>()),
      );
    });
  });

  group('Test getPokemon', () {
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
          'stat': {
            'name': 'attack',
            'url': 'https://pokeapi.co/api/v2/stat/2/',
          },
        },
        {
          'base_stat': defense,
          'effort': 0,
          'stat': {
            'name': 'defense',
            'url': 'https://pokeapi.co/api/v2/stat/3/',
          },
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

    test('makes correct http request', () async {
      when(() => response.statusCode).thenReturn(200);
      when(() => response.body).thenReturn('{}');

      try {
        await apiClient.getPokemon(id: id);
      } catch (_) {}

      verify(
        () => httpClient.get(
          Uri.https('pokeapi.co', '/api/v2/pokemon/$id/'),
        ),
      ).called(1);
    });

    test('returns weather on valid response', () async {
      when(() => response.statusCode).thenReturn(200);
      when(() => response.body).thenReturn(jsonEncode(pokemonMap));

      final result = await apiClient.getPokemon(id: id);

      expect(
        result,
        isA<Pokemon>()
            .having((p) => p.id, 'id', id)
            .having((p) => p.name, 'name', name)
            .having((p) => p.types.length, 'types.length', 2)
            .having((p) => p.types[0].value, 'types[0].value', type01)
            .having((p) => p.types[1].value, 'types[1].value', type02)
            .having((p) => p.height, 'height', height)
            .having((p) => p.weight, 'weight', weight)
            .having((p) => p.hp, 'hp', hp)
            .having((p) => p.attack, 'attack', attack)
            .having((p) => p.defense, 'defense', defense)
            .having((p) => p.specialAttack, 'specialAttack', specialAttack)
            .having((p) => p.specialDefense, 'specialDefense', specialDefense)
            .having((p) => p.speed, 'speed', speed)
            .having((p) => p.sprite, 'sprite', sprite),
      );
    });

    test('throws PokemonRequestFailure on non-200 response', () async {
      when(() => response.statusCode).thenReturn(400);

      expect(
        () async => apiClient.getPokemon(id: id),
        throwsA(isA<PokemonRequestFailure>()),
      );
    });

    test('throws PokemonNotFoundFailure on empty response', () async {
      when(() => response.statusCode).thenReturn(200);
      when(() => response.body).thenReturn('{}');

      expect(
        () async => apiClient.getPokemon(id: id),
        throwsA(isA<PokemonNotFoundFailure>()),
      );
    });
  });
}
