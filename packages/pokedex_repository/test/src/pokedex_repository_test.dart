import 'package:mocktail/mocktail.dart';
import 'package:poke_api/poke_api.dart' as poke_api_client;
import 'package:pokedex_repository/pokedex_repository.dart';
import 'package:test/test.dart';

class MockPokeApiClient extends Mock implements poke_api_client.PokeApiClient {}

class MockPokemons extends Mock implements poke_api_client.Pokemons {}

class MockPokemon extends Mock implements poke_api_client.Pokemon {}

void main() {
  late poke_api_client.PokeApiClient pokeApiClient;
  late PokedexRepository pokedexRepository;

  group('PokedexRepository', () {
    setUp(() {
      pokeApiClient = MockPokeApiClient();
      pokedexRepository = PokedexRepository(
        pokeApiClient: pokeApiClient,
      );
    });

    group('constructor', () {
      test('instantiates internal poke api client when not injected', () {
        expect(PokedexRepository(), isNotNull);
      });
    });

    group('pokemonsList', () {
      const count = 3;
      const pokemon01 = 'charmander';
      const url01 = 'https://pokeapi.co/api/v2/pokemon/4/';

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

      test('calls getPokemons with correct limit', () async {
        try {
          await pokedexRepository.getPokemons(limit: 1);
        } catch (_) {}

        verify(
          () => pokeApiClient.pokemonsList(limit: 1),
        ).called(1);
      });

      test('throws when pokemonsList fails', () async {
        final exception = Exception('oops');

        when(
          () => pokeApiClient.pokemonsList(
            offset: any(named: 'offset'),
            limit: any(named: 'limit'),
          ),
        ).thenThrow(exception);

        expect(
          () async => pokeApiClient.pokemonsList(limit: 1),
          throwsA(exception),
        );
      });

      test('calls getPokemon with correct name of the pokemon', () async {
        final pokemons = MockPokemons();

        when(() => pokemons.count).thenReturn(count);
        when(() => pokemons.pokemons).thenReturn(
          [
            poke_api_client.PokemonAddress(name: pokemon01, url: url01),
          ],
        );
        when(
          () => pokeApiClient.pokemonsList(
            offset: any(named: 'offset'),
            limit: any(named: 'limit'),
          ),
        ).thenAnswer(
          (_) async => pokemons,
        );

        try {
          await pokedexRepository.getPokemons(limit: 1);
        } catch (_) {}

        verify(
          () => pokeApiClient.getPokemon(name: pokemon01),
        ).called(1);
      });

      test('throws when getPokemon fails', () async {
        final exception = Exception('oops');
        final pokemons = MockPokemons();

        when(() => pokemons.count).thenReturn(count);
        when(() => pokemons.pokemons).thenReturn(
          [
            poke_api_client.PokemonAddress(name: pokemon01, url: url01),
          ],
        );
        when(
          () => pokeApiClient.pokemonsList(
            offset: any(named: 'offset'),
            limit: any(named: 'limit'),
          ),
        ).thenAnswer((_) async => pokemons);
        when(
          () => pokeApiClient.getPokemon(name: any(named: 'name')),
        ).thenThrow(exception);

        expect(
          () async => pokedexRepository.getPokemons(limit: 1),
          throwsA(exception),
        );
      });

      test('returns correct pokemon on success', () async {
        final pokemons = MockPokemons();
        final pokemon = MockPokemon();

        when(() => pokemons.count).thenReturn(count);
        when(() => pokemons.pokemons).thenReturn(
          [
            poke_api_client.PokemonAddress(name: pokemon01, url: url01),
          ],
        );

        when(() => pokemon.id).thenReturn(id);
        when(() => pokemon.name).thenReturn(name);
        when(() => pokemon.types).thenReturn(
          [
            poke_api_client.Type(
              slot: 1,
              type: poke_api_client.SimpleDescription(name: type01),
            ),
            poke_api_client.Type(
              slot: 2,
              type: poke_api_client.SimpleDescription(name: type02),
            ),
          ],
        );
        when(() => pokemon.height).thenReturn(height);
        when(() => pokemon.weight).thenReturn(weight);
        when(() => pokemon.stats).thenReturn(
          [
            poke_api_client.StatElement(
              baseStat: hp,
              effort: 0,
              stat: poke_api_client.SimpleDescription(name: 'hp'),
            ),
            poke_api_client.StatElement(
              baseStat: attack,
              effort: 0,
              stat: poke_api_client.SimpleDescription(name: 'attack'),
            ),
            poke_api_client.StatElement(
              baseStat: defense,
              effort: 0,
              stat: poke_api_client.SimpleDescription(name: 'defense'),
            ),
            poke_api_client.StatElement(
              baseStat: specialAttack,
              effort: 0,
              stat: poke_api_client.SimpleDescription(name: 'special-attack'),
            ),
            poke_api_client.StatElement(
              baseStat: specialDefense,
              effort: 0,
              stat: poke_api_client.SimpleDescription(name: 'special-defense'),
            ),
            poke_api_client.StatElement(
              baseStat: speed,
              effort: 0,
              stat: poke_api_client.SimpleDescription(name: 'speed'),
            ),
          ],
        );
        when(() => pokemon.sprites).thenReturn(
          poke_api_client.Sprites(
            frontDefault: icon,
            other: poke_api_client.Other(
              officialArtwork:
                  poke_api_client.OfficialArtwork(frontDefault: sprite),
            ),
          ),
        );

        when(
          () => pokeApiClient.pokemonsList(
            offset: any(named: 'offset'),
            limit: any(named: 'limit'),
          ),
        ).thenAnswer((_) async => pokemons);
        when(
          () => pokeApiClient.getPokemon(name: any(named: 'name')),
        ).thenAnswer((_) async => pokemon);

        final actual = await pokedexRepository.getPokemons(limit: 1);

        expect(
          actual,
          Pokedex(
            total: count,
            pokemons: [
              Pokemon(
                id: id,
                name: 'Bulbasaur',
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
              ),
            ],
          ),
        );
      });
    });
  });
}
