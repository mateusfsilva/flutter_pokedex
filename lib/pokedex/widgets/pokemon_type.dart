import 'package:flutter/material.dart';
import 'package:flutter_pokedex/pokedex/models/models.dart';
import 'package:flutter_pokedex/pokedex/widgets/widgets.dart';

class PokemonTypes extends StatelessWidget {
  const PokemonTypes({
    super.key,
    required this.types,
  });

  final List<PokemonType> types;

  @override
  Widget build(BuildContext context) => Wrap(
        spacing: 8.0,
        children: types
            .map(
              (type) => TypeChip(type: type),
            )
            .toList(),
      );
}
