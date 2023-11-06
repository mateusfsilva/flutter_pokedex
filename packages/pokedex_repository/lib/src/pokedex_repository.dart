import 'package:poke_api/poke_api.dart' hide Pokemon;
import 'package:pokedex_repository/pokedex_repository.dart';

/// {@template pokedex_repository}
/// Access the Pokemon data
/// {@endtemplate}
class PokedexRepository {
  /// {@macro pokedex_repository}
  PokedexRepository({
    PokeApiClient? pokeApiClient,
  }) : _pokeApiClient = pokeApiClient ?? PokeApiClient();

  final PokeApiClient _pokeApiClient;

  int total = 0;
  List<Pokemon> pokemons = [];

  Future<Pokedex> getPokemons({
    int offset = 0,
    int limit = 20,
  }) async {
    final result = await _pokeApiClient.pokemonsList(
      offset: offset,
      limit: limit,
    );

    total = result.count;

    for (final pokemonAddress in result.pokemons) {
      final poke = await _pokeApiClient.getPokemon(name: pokemonAddress.name);

      pokemons.add(
        Pokemon(
          id: poke.id,
          name: poke.name.toTitleCase(),
          types: poke.types
              .map(
                (type) => PokemonType.fromValue(type.type.name),
              )
              .toList(),
          height: poke.height,
          weight: poke.weight,
          hp: poke.stats.where((stat) => stat.stat.name == 'hp').first.baseStat,
          attack: poke.stats
              .where((stat) => stat.stat.name == 'attack')
              .first
              .baseStat,
          defense: poke.stats
              .where((stat) => stat.stat.name == 'defense')
              .first
              .baseStat,
          specialAttack: poke.stats
              .where((stat) => stat.stat.name == 'special-attack')
              .first
              .baseStat,
          specialDefense: poke.stats
              .where((stat) => stat.stat.name == 'special-defense')
              .first
              .baseStat,
          speed: poke.stats
              .where((stat) => stat.stat.name == 'speed')
              .first
              .baseStat,
          icon: poke.sprites.frontDefault,
          sprite: poke.sprites.other.officialArtwork.frontDefault,
        ),
      );
    }

    return Pokedex(total: total, pokemons: pokemons);
  }
}

extension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
