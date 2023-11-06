import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/pokedex/pokedex.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class MockPokedexCubit extends MockCubit<PokedexState>
    implements PokedexCubit {}

void main() {
  late PokedexCubit pokedexCubit;

  setUpAll(() async {
    registerFallbackValue(PokedexOrder.id);
  });

  setUp(() async {
    pokedexCubit = MockPokedexCubit();

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
  });

  group('Test PokemonsList', () {
    testWidgets(
        'renders CircularProgressIndicator '
        'when Pokedex status is initial', (tester) async {
      await tester.pumpApp(
        BlocProvider<PokedexCubit>.value(
          value: pokedexCubit,
          child: const Material(
            child: PokemonsList(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        'renders CircularProgressIndicator '
        'when Pokedex status is loading', (tester) async {
      final state = PokedexState().copyWith(status: PokedexStatus.loading);
      whenListen(
        pokedexCubit,
        Stream.value(state),
        initialState: state,
      );

      await tester.pumpApp(
        BlocProvider<PokedexCubit>.value(
          value: pokedexCubit,
          child: const Material(
            child: PokemonsList(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        'renders failed to load Pokemons text '
        'when Pokedex status is failure', (tester) async {
      final state = PokedexState().copyWith(status: PokedexStatus.failure);
      whenListen(
        pokedexCubit,
        Stream.value(state),
        initialState: state,
      );

      final localization = await tester.pumpApp(
        BlocProvider<PokedexCubit>.value(
          value: pokedexCubit,
          child: const Material(
            child: PokemonsList(),
          ),
        ),
      );

      expect(
        find.text(localization.pokedexFailedToFetchPokemons),
        findsOneWidget,
      );
    });

    testWidgets(
        'renders no Pokemons text '
        'when Pokedex status is success but with 0 Pokemons', (tester) async {
      final state = PokedexState().copyWith(status: PokedexStatus.success);
      whenListen(
        pokedexCubit,
        Stream.value(state),
        initialState: state,
      );

      final localization = await tester.pumpApp(
        BlocProvider<PokedexCubit>.value(
          value: pokedexCubit,
          child: const Material(
            child: PokemonsList(),
          ),
        ),
      );

      expect(find.text(localization.pokedexNoPokemonFound), findsOneWidget);
    });

    testWidgets(
        'renders 5 Pokemons and a bottom loader when Pokemons max is not reached yet',
        (tester) async {
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

        await tester.pumpApp(
          BlocProvider<PokedexCubit>.value(
            value: pokedexCubit,
            child: const Material(
              child: PokemonsList(),
            ),
          ),
        );

        expect(find.byType(PokemonListItem), findsNWidgets(5));
        expect(find.byType(BottomLoader), findsOneWidget);
      });
    });

    testWidgets('does not render bottom loader when Pokemons max is reached',
        (tester) async {
      provideMockedNetworkImages(() async {
        final pokedex = Pokedex(
          orderBy: PokedexOrder.id,
          completed: true,
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

        await tester.pumpApp(
          BlocProvider<PokedexCubit>.value(
            value: pokedexCubit,
            child: const Material(
              child: PokemonsList(),
            ),
          ),
        );

        expect(find.byType(BottomLoader), findsNothing);
      });
    });

    testWidgets('fetches more Pokemons when scrolled to the bottom',
        (tester) async {
      await tester.binding.setSurfaceSize(const Size(400, 300));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      provideMockedNetworkImages(() async {
        final pokedex = Pokedex(
          orderBy: PokedexOrder.id,
          completed: true,
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

        await tester.pumpApp(
          BlocProvider<PokedexCubit>.value(
            value: pokedexCubit,
            child: const Material(
              child: PokemonsList(),
            ),
          ),
        );

        await tester.drag(find.byType(PokemonsList), const Offset(0, -500));

        verify(() => pokedexCubit.loadMore()).called(1);
      });
    });
  });
}
