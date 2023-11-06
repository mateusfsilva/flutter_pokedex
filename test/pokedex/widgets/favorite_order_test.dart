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
      () => pokedexCubit.orderBy(any()),
    ).thenAnswer((_) async => Future.value());
  });

  group('Test FavoriteOrder', () {
    testWidgets('render all the widgets (unchecked)', (tester) async {
      final localization = await tester.pumpApp(
        BlocProvider<PokedexCubit>.value(
          value: pokedexCubit,
          child: const Material(
            child: FavoriteOrder(),
          ),
        ),
      );

      expect(find.text(localization.pokedexOrderByFavorites), findsOneWidget);
      final checkbox = find.byType(Checkbox);
      expect(checkbox, findsOneWidget);
      expect(tester.widget<Checkbox>(checkbox).value, isFalse);

      await tester.tap(checkbox);

      verify(() => pokedexCubit.orderBy(PokedexOrder.favorites));
    });

    testWidgets('render all the widgets (checked)', (tester) async {
      final state = PokedexState().copyWith(
        pokedex: Pokedex.empty().copyWith(
          orderBy: PokedexOrder.favorites,
        ),
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
            child: FavoriteOrder(),
          ),
        ),
      );

      expect(find.text(localization.pokedexOrderByFavorites), findsOneWidget);
      final checkbox = find.byType(Checkbox);
      expect(checkbox, findsOneWidget);
      expect(tester.widget<Checkbox>(checkbox).value, isTrue);

      await tester.tap(checkbox);

      verify(() => pokedexCubit.orderBy(PokedexOrder.id));
    });
  });
}
