import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/l10n/l10n.dart';
import 'package:flutter_pokedex/pokedex/pokedex.dart';

class PokemonListItem extends StatelessWidget {
  const PokemonListItem({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) => Material(
        child: ListTile(
          leading: Image.network(
            pokemon.icon,
            semanticLabel: context.l10n.pokemonIconSemanticLabel(pokemon.name),
          ),
          title: Text(
            pokemon.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          subtitle: PokemonTypes(types: pokemon.types),
          trailing: IconButton(
            icon: Icon(
              pokemon.favorite ? Icons.star_outlined : Icons.star_outline,
            ),
            onPressed: () => context
                .read<PokedexCubit>()
                .toggleFavorite(pokemonID: pokemon.id),
          ),
        ),
      );
}
