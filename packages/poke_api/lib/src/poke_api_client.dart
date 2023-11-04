import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:poke_api/poke_api.dart';

/// {@template poke_api}
/// Access the PokeAPI.co
/// {@endtemplate}
class PokeApiClient {
  /// {@macro poke_api}
  PokeApiClient({
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  static const _baseURL = 'pokeapi.co';

  /// Get a list of all Pokemons.
  Future<Pokemons> pokemonsList({
    int offset = 0,
    int limit = 30,
  }) async {
    final request = Uri.https(
      _baseURL,
      '/api/v2/pokemon',
      {
        'offset': '$offset',
        'limit': '$limit',
      },
    );

    final response = await _httpClient.get(request);

    if (response.statusCode != 200) {
      throw PokemonsRequestFailure();
    }

    try {
      final pokemons = Pokemons.fromJson(response.body);

      if (pokemons.pokemons.isEmpty) {
        throw PokemonsNotFoundFailure();
      }

      return pokemons;
    } catch (_) {
      throw PokemonsNotFoundFailure();
    }
  }

  /// Get the info on the specified Pokemon.
  Future<Pokemon> getPokemon({
    required String name,
  }) async {
    final request = Uri.https(_baseURL, '/api/v2/pokemon/$name/');

    final response = await _httpClient.get(request);

    if (response.statusCode != 200) {
      throw PokemonRequestFailure();
    }

    try {
      final pokemon = Pokemon.fromJson(response.body);

      return pokemon;
    } catch (_) {
      throw PokemonNotFoundFailure();
    }
  }
}

/// Exception thrown when pokemonsList fails.
class PokemonsRequestFailure implements Exception {}

/// Exception thrown when the provided indexes are not found.
class PokemonsNotFoundFailure implements Exception {}

/// Exception thrown when getPokemon fails.
class PokemonRequestFailure implements Exception {}

/// Exception thrown when pokemon for provided id is not found.
class PokemonNotFoundFailure implements Exception {}
