import 'package:flutter/material.dart';
import 'package:flutter_pokedex/pokedex/pokedex.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('Test BottomLoader', () {
    testWidgets('render all the widgets', (tester) async {
      await tester.pumpApp(
        const Material(
          child: BottomLoader(),
        ),
      );

      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
