import 'package:flutter/material.dart';
import 'package:flutter_pokedex/pokedex/pokedex.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('Test TypeChip', () {
    testWidgets('render a normal type', (tester) async {
      final localization = await tester.pumpApp(
        const Material(
          child: TypeChip(type: PokemonType.normal),
        ),
      );

      final chip = find.byType(Chip);
      expect(chip, findsOneWidget);
      expect(find.text(localization.pokemonTypeNormal), findsOneWidget);

      final chipWidget = tester.widget<Chip>(chip);
      expect(
        chipWidget.backgroundColor,
        isSameColorAs(const Color(0xFF919AA2)),
      );
      expect(
        chipWidget.labelStyle?.color,
        isSameColorAs(const Color(0xFF000000)),
      );
    });

    testWidgets('render a fighting type', (tester) async {
      final localization = await tester.pumpApp(
        const Material(
          child: TypeChip(type: PokemonType.fighting),
        ),
      );

      final chip = find.byType(Chip);
      expect(chip, findsOneWidget);
      expect(find.text(localization.pokemonTypeFighting), findsOneWidget);

      final chipWidget = tester.widget<Chip>(chip);
      expect(
        chipWidget.backgroundColor,
        isSameColorAs(const Color(0xFFCE416B)),
      );
      expect(
        chipWidget.labelStyle?.color,
        isSameColorAs(const Color(0xFFFFFFFF)),
      );
    });

    testWidgets('render a flying type', (tester) async {
      final localization = await tester.pumpApp(
        const Material(
          child: TypeChip(type: PokemonType.flying),
        ),
      );

      final chip = find.byType(Chip);
      expect(chip, findsOneWidget);
      expect(find.text(localization.pokemonTypeFlying), findsOneWidget);

      final chipWidget = tester.widget<Chip>(chip);
      expect(
        chipWidget.backgroundColor,
        isSameColorAs(const Color(0xFF89AAE3)),
      );
      expect(
        chipWidget.labelStyle?.color,
        isSameColorAs(const Color(0xFF000000)),
      );
    });

    testWidgets('render a poison type', (tester) async {
      final localization = await tester.pumpApp(
        const Material(
          child: TypeChip(type: PokemonType.poison),
        ),
      );

      final chip = find.byType(Chip);
      expect(chip, findsOneWidget);
      expect(find.text(localization.pokemonTypePoison), findsOneWidget);

      final chipWidget = tester.widget<Chip>(chip);
      expect(
        chipWidget.backgroundColor,
        isSameColorAs(const Color(0xFFB567CE)),
      );
      expect(
        chipWidget.labelStyle?.color,
        isSameColorAs(const Color(0xFF000000)),
      );
    });

    testWidgets('render a ground type', (tester) async {
      final localization = await tester.pumpApp(
        const Material(
          child: TypeChip(type: PokemonType.ground),
        ),
      );

      final chip = find.byType(Chip);
      expect(chip, findsOneWidget);
      expect(find.text(localization.pokemonTypeGround), findsOneWidget);

      final chipWidget = tester.widget<Chip>(chip);
      expect(
        chipWidget.backgroundColor,
        isSameColorAs(const Color(0xFFD97845)),
      );
      expect(
        chipWidget.labelStyle?.color,
        isSameColorAs(const Color(0xFF000000)),
      );
    });

    testWidgets('render a rock type', (tester) async {
      final localization = await tester.pumpApp(
        const Material(
          child: TypeChip(type: PokemonType.rock),
        ),
      );

      final chip = find.byType(Chip);
      expect(chip, findsOneWidget);
      expect(find.text(localization.pokemonTypeRock), findsOneWidget);

      final chipWidget = tester.widget<Chip>(chip);
      expect(
        chipWidget.backgroundColor,
        isSameColorAs(const Color(0xFFC5B78C)),
      );
      expect(
        chipWidget.labelStyle?.color,
        isSameColorAs(const Color(0xFF000000)),
      );
    });

    testWidgets('render a bug type', (tester) async {
      final localization = await tester.pumpApp(
        const Material(
          child: TypeChip(type: PokemonType.bug),
        ),
      );

      final chip = find.byType(Chip);
      expect(chip, findsOneWidget);
      expect(find.text(localization.pokemonTypeBug), findsOneWidget);

      final chipWidget = tester.widget<Chip>(chip);
      expect(
        chipWidget.backgroundColor,
        isSameColorAs(const Color(0xFF91C12F)),
      );
      expect(
        chipWidget.labelStyle?.color,
        isSameColorAs(const Color(0xFF000000)),
      );
    });

    testWidgets('render a ghost type', (tester) async {
      final localization = await tester.pumpApp(
        const Material(
          child: TypeChip(type: PokemonType.ghost),
        ),
      );

      final chip = find.byType(Chip);
      expect(chip, findsOneWidget);
      expect(find.text(localization.pokemonTypeGhost), findsOneWidget);

      final chipWidget = tester.widget<Chip>(chip);
      expect(
        chipWidget.backgroundColor,
        isSameColorAs(const Color(0xFF5269AD)),
      );
      expect(
        chipWidget.labelStyle?.color,
        isSameColorAs(const Color(0xFFFFFFFF)),
      );
    });

    testWidgets('render a steel type', (tester) async {
      final localization = await tester.pumpApp(
        const Material(
          child: TypeChip(type: PokemonType.steel),
        ),
      );

      final chip = find.byType(Chip);
      expect(chip, findsOneWidget);
      expect(find.text(localization.pokemonTypeSteel), findsOneWidget);

      final chipWidget = tester.widget<Chip>(chip);
      expect(
        chipWidget.backgroundColor,
        isSameColorAs(const Color(0xFF5A8EA2)),
      );
      expect(
        chipWidget.labelStyle?.color,
        isSameColorAs(const Color(0xFF000000)),
      );
    });

    testWidgets('render a fire type', (tester) async {
      final localization = await tester.pumpApp(
        const Material(
          child: TypeChip(type: PokemonType.fire),
        ),
      );

      final chip = find.byType(Chip);
      expect(chip, findsOneWidget);
      expect(find.text(localization.pokemonTypeFire), findsOneWidget);

      final chipWidget = tester.widget<Chip>(chip);
      expect(
        chipWidget.backgroundColor,
        isSameColorAs(const Color(0xFFFF9D55)),
      );
      expect(
        chipWidget.labelStyle?.color,
        isSameColorAs(const Color(0xFF000000)),
      );
    });

    testWidgets('render a water type', (tester) async {
      final localization = await tester.pumpApp(
        const Material(
          child: TypeChip(type: PokemonType.water),
        ),
      );

      final chip = find.byType(Chip);
      expect(chip, findsOneWidget);
      expect(find.text(localization.pokemonTypeWater), findsOneWidget);

      final chipWidget = tester.widget<Chip>(chip);
      expect(
        chipWidget.backgroundColor,
        isSameColorAs(const Color(0xFF5090D6)),
      );
      expect(
        chipWidget.labelStyle?.color,
        isSameColorAs(const Color(0xFF000000)),
      );
    });

    testWidgets('render a grass type', (tester) async {
      final localization = await tester.pumpApp(
        const Material(
          child: TypeChip(type: PokemonType.grass),
        ),
      );

      final chip = find.byType(Chip);
      expect(chip, findsOneWidget);
      expect(find.text(localization.pokemonTypeGrass), findsOneWidget);

      final chipWidget = tester.widget<Chip>(chip);
      expect(
        chipWidget.backgroundColor,
        isSameColorAs(const Color(0xFF63BC5A)),
      );
      expect(
        chipWidget.labelStyle?.color,
        isSameColorAs(const Color(0xFF000000)),
      );
    });

    testWidgets('render a electric type', (tester) async {
      final localization = await tester.pumpApp(
        const Material(
          child: TypeChip(type: PokemonType.electric),
        ),
      );

      final chip = find.byType(Chip);
      expect(chip, findsOneWidget);
      expect(find.text(localization.pokemonTypeElectric), findsOneWidget);

      final chipWidget = tester.widget<Chip>(chip);
      expect(
        chipWidget.backgroundColor,
        isSameColorAs(const Color(0xFFF4D33C)),
      );
      expect(
        chipWidget.labelStyle?.color,
        isSameColorAs(const Color(0xFF000000)),
      );
    });

    testWidgets('render a psychic type', (tester) async {
      final localization = await tester.pumpApp(
        const Material(
          child: TypeChip(type: PokemonType.psychic),
        ),
      );

      final chip = find.byType(Chip);
      expect(chip, findsOneWidget);
      expect(find.text(localization.pokemonTypePsychic), findsOneWidget);

      final chipWidget = tester.widget<Chip>(chip);
      expect(
        chipWidget.backgroundColor,
        isSameColorAs(const Color(0xFFFA7179)),
      );
      expect(
        chipWidget.labelStyle?.color,
        isSameColorAs(const Color(0xFF000000)),
      );
    });

    testWidgets('render a ice type', (tester) async {
      final localization = await tester.pumpApp(
        const Material(
          child: TypeChip(type: PokemonType.ice),
        ),
      );

      final chip = find.byType(Chip);
      expect(chip, findsOneWidget);
      expect(find.text(localization.pokemonTypeIce), findsOneWidget);

      final chipWidget = tester.widget<Chip>(chip);
      expect(
        chipWidget.backgroundColor,
        isSameColorAs(const Color(0xFF73CEC0)),
      );
      expect(
        chipWidget.labelStyle?.color,
        isSameColorAs(const Color(0xFF000000)),
      );
    });

    testWidgets('render a dragon type', (tester) async {
      final localization = await tester.pumpApp(
        const Material(
          child: TypeChip(type: PokemonType.dragon),
        ),
      );

      final chip = find.byType(Chip);
      expect(chip, findsOneWidget);
      expect(find.text(localization.pokemonTypeDragon), findsOneWidget);

      final chipWidget = tester.widget<Chip>(chip);
      expect(
        chipWidget.backgroundColor,
        isSameColorAs(const Color(0xFF0B6DC3)),
      );
      expect(
        chipWidget.labelStyle?.color,
        isSameColorAs(const Color(0xFFFFFFFF)),
      );
    });

    testWidgets('render a dark type', (tester) async {
      final localization = await tester.pumpApp(
        const Material(
          child: TypeChip(type: PokemonType.dark),
        ),
      );

      final chip = find.byType(Chip);
      expect(chip, findsOneWidget);
      expect(find.text(localization.pokemonTypeDark), findsOneWidget);

      final chipWidget = tester.widget<Chip>(chip);
      expect(
        chipWidget.backgroundColor,
        isSameColorAs(const Color(0xFF5A5465)),
      );
      expect(
        chipWidget.labelStyle?.color,
        isSameColorAs(const Color(0xFFFFFFFF)),
      );
    });

    testWidgets('render a fairy type', (tester) async {
      final localization = await tester.pumpApp(
        const Material(
          child: TypeChip(type: PokemonType.fairy),
        ),
      );

      final chip = find.byType(Chip);
      expect(chip, findsOneWidget);
      expect(find.text(localization.pokemonTypeFairy), findsOneWidget);

      final chipWidget = tester.widget<Chip>(chip);
      expect(
        chipWidget.backgroundColor,
        isSameColorAs(const Color(0xFFEC8FE6)),
      );
      expect(
        chipWidget.labelStyle?.color,
        isSameColorAs(const Color(0xFF000000)),
      );
    });

    testWidgets('render a unknown type', (tester) async {
      final localization = await tester.pumpApp(
        const Material(
          child: TypeChip(type: PokemonType.unknown),
        ),
      );

      final chip = find.byType(Chip);
      expect(chip, findsOneWidget);
      expect(find.text(localization.pokemonTypeUnknown), findsOneWidget);

      final chipWidget = tester.widget<Chip>(chip);
      expect(
        chipWidget.backgroundColor,
        isSameColorAs(const Color(0xFFFFFFFF)),
      );
      expect(
        chipWidget.labelStyle?.color,
        isSameColorAs(const Color(0xFF000000)),
      );
    });

    testWidgets('render a shadow type', (tester) async {
      final localization = await tester.pumpApp(
        const Material(
          child: TypeChip(type: PokemonType.shadow),
        ),
      );

      final chip = find.byType(Chip);
      expect(chip, findsOneWidget);
      expect(find.text(localization.pokemonTypeShadow), findsOneWidget);

      final chipWidget = tester.widget<Chip>(chip);
      expect(
        chipWidget.backgroundColor,
        isSameColorAs(const Color(0xFF333333)),
      );
      expect(
        chipWidget.labelStyle?.color,
        isSameColorAs(const Color(0xFFFFFFFF)),
      );
    });
  });
}
