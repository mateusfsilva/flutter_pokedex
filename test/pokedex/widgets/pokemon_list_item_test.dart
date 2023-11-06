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

  setUp(() async {
    pokedexCubit = MockPokedexCubit();

    whenListen(
      pokedexCubit,
      Stream.value(PokedexState()),
      initialState: PokedexState(),
    );
    when(
      () => pokedexCubit.toggleFavorite(pokemonID: any(named: 'pokemonID')),
    ).thenAnswer((_) async => Future.value());
  });

  group('Test PokemonListItem', () {
    testWidgets('render all the widgets (favorite)', (tester) async {
      provideMockedNetworkImages(() async {
        final localization = await tester.pumpApp(
          BlocProvider<PokedexCubit>.value(
            value: pokedexCubit,
            child: Material(
              child: PokemonListItem(pokemon: pokemon01),
            ),
          ),
        );

        expect(find.byType(ListTile), findsOneWidget);

        final image = find.byType(Image);
        expect(image, findsOneWidget);
        final imageWidget = tester.widget<Image>(image);
        expect(
          imageWidget.semanticLabel,
          localization.pokemonIconSemanticLabel(pokemon01.name),
        );
        expect(find.text(pokemon01.name), findsOneWidget);
        expect(find.byType(PokemonTypes), findsOneWidget);
        expect(find.byIcon(Icons.star_outlined), findsOneWidget);

        final button = find.byType(IconButton);
        expect(button, findsOneWidget);
        await tester.tap(button);

        verify(() => pokedexCubit.toggleFavorite(pokemonID: pokemon01.id));
      });
    });

    testWidgets('render all the widgets', (tester) async {
      provideMockedNetworkImages(() async {
        final localization = await tester.pumpApp(
          BlocProvider<PokedexCubit>.value(
            value: pokedexCubit,
            child: Material(
              child: PokemonListItem(pokemon: pokemon02),
            ),
          ),
        );

        expect(find.byType(ListTile), findsOneWidget);

        final image = find.byType(Image);
        expect(image, findsOneWidget);
        final imageWidget = tester.widget<Image>(image);
        expect(
          imageWidget.semanticLabel,
          localization.pokemonIconSemanticLabel(pokemon02.name),
        );
        expect(find.text(pokemon02.name), findsOneWidget);
        expect(find.byType(PokemonTypes), findsOneWidget);
        expect(find.byIcon(Icons.star_outline), findsOneWidget);

        final button = find.byType(IconButton);
        expect(button, findsOneWidget);
        await tester.tap(button);

        verify(() => pokedexCubit.toggleFavorite(pokemonID: pokemon02.id));
      });
    });
  });
}
