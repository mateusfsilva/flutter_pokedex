import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/pokedex/pokedex.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex_repository/pokedex_repository.dart'
    as pokedex_repository;

import '../../helpers/helpers.dart';

class MockPokedexCubit extends MockCubit<PokedexState>
    implements PokedexCubit {}

class MockPokedexRepository extends Mock
    implements pokedex_repository.PokedexRepository {}

void main() {
  initHydratedStorage();

  late PokedexCubit pokedexCubit;
  late pokedex_repository.PokedexRepository pokedexRepository;

  setUpAll(() async {
    registerFallbackValue(PokedexOrder.id);
  });

  setUp(() async {
    pokedexCubit = MockPokedexCubit();
    pokedexRepository = MockPokedexRepository();

    whenListen(
      pokedexCubit,
      Stream.value(PokedexState()),
      initialState: PokedexState(),
    );

    when(
      () => pokedexCubit.getPokedex(),
    ).thenAnswer((_) async => Future.value());

    when(
      () => pokedexCubit.loadMore(),
    ).thenAnswer((_) async => Future.value());

    when(
      () => pokedexRepository.getPokemons(
        offset: any(named: 'offset'),
        limit: any(named: 'limit'),
      ),
    ).thenAnswer(
      (_) async => pokedex_repository.Pokedex(
        total: 0,
        pokemons: [],
      ),
    );
  });

  group('PokemonsPage', () {
    testWidgets('render using the static method page', (tester) async {
      final localization = await tester.pumpApp(
        Material(
          child: PokemonsPage.page(
            pokedexRepository: pokedexRepository,
          ),
        ),
      );

      expect(find.text(localization.pokedexAppBarTitle), findsOneWidget);
      expect(find.byType(FavoriteOrder), findsOneWidget);
      expect(find.byType(PokemonsList), findsOneWidget);
    });

    testWidgets('renders PokemonsList', (tester) async {
      provideMockedNetworkImages(() async {
        final pokedex = Pokedex(
          orderBy: PokedexOrder.id,
          completed: false,
          pokemons: [
            pokemon01,
            pokemon02,
            pokemon03,
            pokemon04,
            pokemon05,
          ],
        );
        final state = PokedexState(
          status: PokedexStatus.success,
          pokedex: pokedex,
        );
        whenListen(
          pokedexCubit,
          Stream.value(state),
          initialState: state,
        );

        final localization = await tester.pumpApp(
          BlocProvider<PokedexCubit>.value(
            value: pokedexCubit,
            child: const Material(
              child: PokemonsPage(),
            ),
          ),
        );

        expect(find.text(localization.pokedexAppBarTitle), findsOneWidget);
        expect(find.byType(FavoriteOrder), findsOneWidget);
        expect(find.byType(PokemonsList), findsOneWidget);
      });
    });
  });
}
