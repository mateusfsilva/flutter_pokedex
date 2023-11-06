import 'package:flutter/material.dart';
import 'package:flutter_pokedex/l10n/l10n.dart';
import 'package:flutter_pokedex/pokedex/models/models.dart';

class TypeChip extends StatelessWidget {
  const TypeChip({
    super.key,
    required this.type,
  });

  final PokemonType type;

  @override
  Widget build(BuildContext context) {
    final (backgroundColor, foregroundColor, label) =
        getTypeProperties(context);

    return Chip(
      label: Text(label),
      padding: const EdgeInsets.symmetric(
        horizontal: 4.0,
        vertical: 2.0,
      ),
      labelStyle: Theme.of(context)
          .textTheme
          .bodySmall!
          .copyWith(color: foregroundColor),
      backgroundColor: backgroundColor,
    );
  }

  (Color, Color, String) getTypeProperties(BuildContext context) =>
      switch (type) {
        PokemonType.normal => (
            const Color(0xFF919AA2),
            const Color(0xFF000000),
            context.l10n.pokemonTypeNormal,
          ),
        PokemonType.fighting => (
            const Color(0xFFCE416B),
            const Color(0xFFFFFFFF),
            context.l10n.pokemonTypeFighting,
          ),
        PokemonType.flying => (
            const Color(0xFF89AAE3),
            const Color(0xFF000000),
            context.l10n.pokemonTypeFlying,
          ),
        PokemonType.poison => (
            const Color(0xFFB567CE),
            const Color(0xFF000000),
            context.l10n.pokemonTypePoison,
          ),
        PokemonType.ground => (
            const Color(0xFFD97845),
            const Color(0xFF000000),
            context.l10n.pokemonTypeGround,
          ),
        PokemonType.rock => (
            const Color(0xFFC5B78C),
            const Color(0xFF000000),
            context.l10n.pokemonTypeRock,
          ),
        PokemonType.bug => (
            const Color(0xFF91C12F),
            const Color(0xFF000000),
            context.l10n.pokemonTypeBug,
          ),
        PokemonType.ghost => (
            const Color(0xFF5269AD),
            const Color(0xFFFFFFFF),
            context.l10n.pokemonTypeGhost,
          ),
        PokemonType.steel => (
            const Color(0xFF5A8EA2),
            const Color(0xFF000000),
            context.l10n.pokemonTypeSteel,
          ),
        PokemonType.fire => (
            const Color(0xFFFF9D55),
            const Color(0xFF000000),
            context.l10n.pokemonTypeFire,
          ),
        PokemonType.water => (
            const Color(0xFF5090D6),
            const Color(0xFF000000),
            context.l10n.pokemonTypeWater,
          ),
        PokemonType.grass => (
            const Color(0xFF63BC5A),
            const Color(0xFF000000),
            context.l10n.pokemonTypeGrass,
          ),
        PokemonType.electric => (
            const Color(0xFFF4D33C),
            const Color(0xFF000000),
            context.l10n.pokemonTypeElectric,
          ),
        PokemonType.psychic => (
            const Color(0xFFFA7179),
            const Color(0xFF000000),
            context.l10n.pokemonTypePsychic,
          ),
        PokemonType.ice => (
            const Color(0xFF73CEC0),
            const Color(0xFF000000),
            context.l10n.pokemonTypeIce,
          ),
        PokemonType.dragon => (
            const Color(0xFF0B6DC3),
            const Color(0xFFFFFFFF),
            context.l10n.pokemonTypeDragon,
          ),
        PokemonType.dark => (
            const Color(0xFF5A5465),
            const Color(0xFFFFFFFF),
            context.l10n.pokemonTypeDark,
          ),
        PokemonType.fairy => (
            const Color(0xFFEC8FE6),
            const Color(0xFF000000),
            context.l10n.pokemonTypeFairy,
          ),
        PokemonType.unknown => (
            const Color(0xFFFFFFFF),
            const Color(0xFF000000),
            context.l10n.pokemonTypeUnknown,
          ),
        PokemonType.shadow => (
            const Color(0xFF333333),
            const Color(0xFFFFFFFF),
            context.l10n.pokemonTypeShadow,
          )
      };
}
