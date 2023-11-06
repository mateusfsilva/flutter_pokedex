import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_pokedex/pokedex/cubit/pokedex_cubit.dart';
import 'package:flutter_pokedex/pokedex/models/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex_repository/pokedex_repository.dart'
    as pokedex_repository;

import '../../helpers/hydrated_bloc.dart';

class MockPokedexRepository extends Mock
    implements pokedex_repository.PokedexRepository {}

class MockPokedex extends Mock implements pokedex_repository.Pokedex {}

void main() {
  initHydratedStorage();

  group('Test PokedexCubit', () {
    late pokedex_repository.Pokedex pokedex;
    late pokedex_repository.PokedexRepository pokedexRepository;
    late PokedexCubit pokedexCubit;

    final pokemon01 = pokedex_repository.Pokemon(
      id: 1,
      name: 'Bulbasaur',
      types: [
        pokedex_repository.PokemonType.grass,
        pokedex_repository.PokemonType.poison,
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
    );
    final pokemon02 = pokedex_repository.Pokemon(
      id: 4,
      name: 'charmander',
      types: [
        pokedex_repository.PokemonType.fire,
      ],
      height: 6,
      weight: 85,
      hp: 39,
      attack: 52,
      defense: 43,
      specialAttack: 60,
      specialDefense: 50,
      speed: 65,
      icon:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png',
      sprite:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png',
    );
    final pokemon03 = pokedex_repository.Pokemon(
      id: 7,
      name: 'squirtle',
      types: [
        pokedex_repository.PokemonType.water,
      ],
      height: 5,
      weight: 90,
      hp: 44,
      attack: 48,
      defense: 65,
      specialAttack: 50,
      specialDefense: 64,
      speed: 43,
      icon:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png',
      sprite:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/7.png',
    );

    setUp(() async {
      pokedex = MockPokedex();
      pokedexRepository = MockPokedexRepository();

      when(() => pokedex.total).thenReturn(3);
      when(() => pokedex.pokemons)
          .thenReturn([pokemon01, pokemon02, pokemon03]);
      when(
        () => pokedexRepository.getPokemons(
          offset: any(named: 'offset'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer((_) async => pokedex);

      pokedexCubit = PokedexCubit(pokedexRepository);
    });

    test('initial state is correct', () {
      final pokedexCubit = PokedexCubit(pokedexRepository);

      expect(
        pokedexCubit.state,
        isA<PokedexState>()
            .having((state) => state.status.isInitial, 'isInitial', isTrue)
            .having((state) => state.status.isLoading, 'isLoading', isFalse)
            .having((state) => state.status.isFailure, 'isFailure', isFalse)
            .having((state) => state.status.isSuccess, 'isSuccess', isFalse)
            .having(
              (state) => state.pokedex.orderBy,
              'orderBy',
              PokedexOrder.id,
            )
            .having((state) => state.pokedex.completed, 'completed', isFalse)
            .having((state) => state.pokedex.pokemons, 'pokemons', <Pokemon>[]),
      );
    });

    test('remove duplicates records from an array', () {
      var pokemons = [
        Pokemon.fromRepository(pokemon01),
        Pokemon.fromRepository(pokemon01),
        Pokemon.fromRepository(pokemon02),
      ];

      pokemons = pokemons.unique((p) => p.id, false);

      expect(pokemons.length, 2);
      expect(pokemons.first.id, 1);
      expect(pokemons.last.id, 4);
    });

    group('toJson/fromJson', () {
      test('work properly', () {
        final pokedexCubit = PokedexCubit(pokedexRepository);

        expect(
          pokedexCubit.fromJson(pokedexCubit.toJson(pokedexCubit.state)!),
          pokedexCubit.state,
        );
      });
    });

    group('getPokedex', () {
      blocTest<PokedexCubit, PokedexState>(
        "calls load more with isn't on initial stat",
        build: () => pokedexCubit,
        seed: () => PokedexState(
          status: PokedexStatus.success,
          pokedex: Pokedex(
            orderBy: PokedexOrder.id,
            completed: false,
            pokemons: [
              Pokemon.fromRepository(pokemon01),
            ],
          ),
        ),
        act: (cubit) => cubit.getPokedex(),
        expect: () => [
          PokedexState(
            status: PokedexStatus.success,
            pokedex: Pokedex(
              orderBy: PokedexOrder.id,
              completed: true,
              pokemons: [
                Pokemon.fromRepository(pokemon01),
                Pokemon.fromRepository(pokemon02),
                Pokemon.fromRepository(pokemon03),
              ],
            ),
          ),
        ],
      );

      blocTest<PokedexCubit, PokedexState>(
        'calls getPokedex',
        build: () => pokedexCubit,
        act: (cubit) => cubit.getPokedex(),
        verify: (_) {
          verify(() => pokedexRepository.getPokemons()).called(1);
        },
      );

      blocTest<PokedexCubit, PokedexState>(
        'emits [loading, failure] when getPokedex throws',
        setUp: () {
          when(
            () => pokedexRepository.getPokemons(),
          ).thenThrow(Exception('oops'));
        },
        build: () => pokedexCubit,
        act: (cubit) => cubit.getPokedex(),
        expect: () => <PokedexState>[
          PokedexState(status: PokedexStatus.loading),
          PokedexState(status: PokedexStatus.failure),
        ],
      );

      blocTest<PokedexCubit, PokedexState>(
        'emits [loading, success] when getPokedex',
        build: () => pokedexCubit,
        act: (cubit) => cubit.getPokedex(),
        expect: () => <dynamic>[
          PokedexState(status: PokedexStatus.loading),
          isA<PokedexState>()
              .having((state) => state.status, 'status', PokedexStatus.success)
              .having(
                (state) => state.pokedex,
                'pokedex',
                isA<Pokedex>()
                    .having(
                      (pokedex) => pokedex.orderBy,
                      'orderBy',
                      PokedexOrder.id,
                    )
                    .having((pokedex) => pokedex.completed, 'completed', false)
                    .having(
                  (pokedex) => pokedex.pokemons,
                  'pokemons',
                  [
                    Pokemon.fromRepository(pokemon01),
                    Pokemon.fromRepository(pokemon02),
                    Pokemon.fromRepository(pokemon03),
                  ],
                ),
              ),
        ],
      );
    });

    group('loadMore', () {
      blocTest<PokedexCubit, PokedexState>(
        'emits nothing when status is not success',
        build: () => pokedexCubit,
        act: (cubit) => cubit.loadMore(),
        expect: () => <PokedexState>[],
        verify: (_) {
          verifyNever(() => pokedexRepository.getPokemons());
        },
      );

      blocTest<PokedexCubit, PokedexState>(
        'invokes getPokedex with correctly',
        build: () => pokedexCubit,
        seed: () => PokedexState(
          status: PokedexStatus.success,
          pokedex: Pokedex(
            orderBy: PokedexOrder.id,
            completed: false,
            pokemons: [
              Pokemon.fromRepository(pokemon01),
              Pokemon.fromRepository(pokemon02),
              Pokemon.fromRepository(pokemon03),
            ],
          ),
        ),
        act: (cubit) => cubit.loadMore(),
        verify: (_) {
          verify(
            () => pokedexRepository.getPokemons(
              offset: any(named: 'offset'),
              limit: any(named: 'limit'),
            ),
          ).called(1);
        },
      );

      blocTest<PokedexCubit, PokedexState>(
        'emits nothing when exception is thrown',
        setUp: () {
          when(
            () => pokedexRepository.getPokemons(
              offset: any(named: 'offset'),
              limit: any(named: 'limit'),
            ),
          ).thenThrow(Exception('oops'));
        },
        build: () => pokedexCubit,
        seed: () => PokedexState(
          status: PokedexStatus.success,
          pokedex: Pokedex(
            orderBy: PokedexOrder.id,
            completed: false,
            pokemons: [
              Pokemon.fromRepository(pokemon01),
              Pokemon.fromRepository(pokemon02),
              Pokemon.fromRepository(pokemon03),
            ],
          ),
        ),
        act: (cubit) => cubit.loadMore(),
        expect: () => <PokedexState>[],
      );

      blocTest<PokedexCubit, PokedexState>(
        'emits updated pokedex',
        build: () => pokedexCubit,
        seed: () => PokedexState(
          status: PokedexStatus.success,
          pokedex: Pokedex(
            orderBy: PokedexOrder.id,
            completed: false,
            pokemons: [],
          ),
        ),
        act: (cubit) => cubit.loadMore(),
        expect: () => <Matcher>[
          isA<PokedexState>()
              .having((w) => w.status, 'status', PokedexStatus.success)
              .having(
                (state) => state.pokedex,
                'pokedex',
                isA<Pokedex>()
                    .having(
                      (pokedex) => pokedex.orderBy,
                      'orderBy',
                      PokedexOrder.id,
                    )
                    .having((pokedex) => pokedex.completed, 'completed', true)
                    .having(
                  (pokedex) => pokedex.pokemons,
                  'pokemons',
                  [
                    Pokemon.fromRepository(pokemon01),
                    Pokemon.fromRepository(pokemon02),
                    Pokemon.fromRepository(pokemon03),
                  ],
                ),
              ),
        ],
      );

      blocTest<PokedexCubit, PokedexState>(
        'emits updated pokedex ordering by favorites',
        build: () => pokedexCubit,
        setUp: () {
          when(() => pokedex.pokemons).thenReturn([
            pokemon03,
            pokemon01,
          ]);
        },
        seed: () => PokedexState(
          status: PokedexStatus.success,
          pokedex: Pokedex(
            orderBy: PokedexOrder.favorites,
            completed: false,
            pokemons: [
              Pokemon.fromRepository(pokemon02).copyWith(favorite: true),
            ],
          ),
        ),
        act: (cubit) => cubit.loadMore(),
        expect: () => <Matcher>[
          isA<PokedexState>()
              .having((w) => w.status, 'status', PokedexStatus.success)
              .having(
                (state) => state.pokedex,
                'pokedex',
                isA<Pokedex>()
                    .having(
                      (pokedex) => pokedex.orderBy,
                      'orderBy',
                      PokedexOrder.favorites,
                    )
                    .having((pokedex) => pokedex.completed, 'completed', true)
                    .having(
                  (pokedex) => pokedex.pokemons,
                  'pokemons',
                  [
                    Pokemon.fromRepository(pokemon02).copyWith(favorite: true),
                    Pokemon.fromRepository(pokemon01),
                    Pokemon.fromRepository(pokemon03),
                  ],
                ),
              ),
        ],
      );
    });

    group('orderBy', () {
      blocTest<PokedexCubit, PokedexState>(
        'emits updated pokemon after order it by favorites',
        build: () => pokedexCubit,
        seed: () => PokedexState(
          status: PokedexStatus.success,
          pokedex: Pokedex(
            orderBy: PokedexOrder.id,
            completed: false,
            pokemons: [
              Pokemon.fromRepository(pokemon03),
              Pokemon.fromRepository(pokemon02).copyWith(favorite: true),
              Pokemon.fromRepository(pokemon01),
            ],
          ),
        ),
        act: (cubit) => cubit.orderBy(PokedexOrder.favorites),
        expect: () => <PokedexState>[
          PokedexState(
            status: PokedexStatus.success,
            pokedex: Pokedex(
              orderBy: PokedexOrder.favorites,
              completed: false,
              pokemons: [
                Pokemon.fromRepository(pokemon02).copyWith(favorite: true),
                Pokemon.fromRepository(pokemon01),
                Pokemon.fromRepository(pokemon03),
              ],
            ),
          ),
        ],
      );

      blocTest<PokedexCubit, PokedexState>(
        'emits updated pokemon after order it by id',
        build: () => pokedexCubit,
        seed: () => PokedexState(
          status: PokedexStatus.success,
          pokedex: Pokedex(
            orderBy: PokedexOrder.favorites,
            completed: false,
            pokemons: [
              Pokemon.fromRepository(pokemon03),
              Pokemon.fromRepository(pokemon02).copyWith(favorite: true),
              Pokemon.fromRepository(pokemon01),
            ],
          ),
        ),
        act: (cubit) => cubit.orderBy(PokedexOrder.id),
        expect: () => <PokedexState>[
          PokedexState(
            status: PokedexStatus.success,
            pokedex: Pokedex(
              orderBy: PokedexOrder.id,
              completed: false,
              pokemons: [
                Pokemon.fromRepository(pokemon01),
                Pokemon.fromRepository(pokemon02).copyWith(favorite: true),
                Pokemon.fromRepository(pokemon03),
              ],
            ),
          ),
        ],
      );
    });

    group('toggleFavorite', () {
      blocTest<PokedexCubit, PokedexState>(
        'emits updated pokemon '
        'when id is found',
        build: () => pokedexCubit,
        seed: () => PokedexState(
          status: PokedexStatus.success,
          pokedex: Pokedex(
            orderBy: PokedexOrder.id,
            completed: false,
            pokemons: [
              Pokemon.fromRepository(pokemon01),
              Pokemon.fromRepository(pokemon02),
              Pokemon.fromRepository(pokemon03),
            ],
          ),
        ),
        act: (cubit) => cubit.toggleFavorite(pokemonID: 4),
        expect: () => <PokedexState>[
          PokedexState(
            status: PokedexStatus.success,
            pokedex: Pokedex(
              orderBy: PokedexOrder.id,
              completed: false,
              pokemons: [
                Pokemon.fromRepository(pokemon01),
                Pokemon.fromRepository(pokemon02).copyWith(favorite: true),
                Pokemon.fromRepository(pokemon03),
              ],
            ),
          ),
        ],
      );

      blocTest<PokedexCubit, PokedexState>(
        'emits updated pokemon '
        'when id is found '
        'ordered by favorites',
        build: () => pokedexCubit,
        seed: () => PokedexState(
          status: PokedexStatus.success,
          pokedex: Pokedex(
            orderBy: PokedexOrder.favorites,
            completed: false,
            pokemons: [
              Pokemon.fromRepository(pokemon01),
              Pokemon.fromRepository(pokemon02),
              Pokemon.fromRepository(pokemon03),
            ],
          ),
        ),
        act: (cubit) => cubit.toggleFavorite(pokemonID: 4),
        expect: () => <PokedexState>[
          PokedexState(
            status: PokedexStatus.success,
            pokedex: Pokedex(
              orderBy: PokedexOrder.favorites,
              completed: false,
              pokemons: [
                Pokemon.fromRepository(pokemon02).copyWith(favorite: true),
                Pokemon.fromRepository(pokemon01),
                Pokemon.fromRepository(pokemon03),
              ],
            ),
          ),
        ],
      );

      blocTest<PokedexCubit, PokedexState>(
        'emits same state '
        'when id is not found',
        build: () => pokedexCubit,
        seed: () => PokedexState(
          status: PokedexStatus.success,
          pokedex: Pokedex(
            orderBy: PokedexOrder.id,
            completed: false,
            pokemons: [
              Pokemon.fromRepository(pokemon01),
              Pokemon.fromRepository(pokemon02),
              Pokemon.fromRepository(pokemon03),
            ],
          ),
        ),
        act: (cubit) => cubit.toggleFavorite(pokemonID: 2),
        expect: () => <PokedexState>[],
      );
    });
  });
}
