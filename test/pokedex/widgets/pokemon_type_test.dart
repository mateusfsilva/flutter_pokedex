import 'package:flutter/material.dart';
import 'package:flutter_pokedex/pokedex/pokedex.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('Test PokemonTypes', () {
    testWidgets('render all the widgets', (tester) async {
      await tester.pumpApp(
        const Material(
          child: PokemonTypes(
            types: [
              PokemonType.shadow,
              PokemonType.fairy,
            ],
          ),
        ),
      );

      expect(find.byType(Wrap), findsOneWidget);
      expect(find.byType(TypeChip), findsNWidgets(2));
    });
  });
}
