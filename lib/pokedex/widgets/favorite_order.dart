import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/pokedex/cubit/pokedex_cubit.dart';
import 'package:flutter_pokedex/pokedex/models/models.dart';

class FavoriteOrder extends StatelessWidget {
  const FavoriteOrder({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: [
          const Text(
            'Favoritos primeiro',
          ),
          const SizedBox(
            width: 8.0,
          ),
          Checkbox(
            value: orderByFavorites(context),
            onChanged: (value) => context
                .read<PokedexCubit>()
                .orderBy(value! ? PokedexOrder.favorites : PokedexOrder.id),
          ),
        ],
      );

  bool orderByFavorites(BuildContext context) =>
      switch (context.watch<PokedexCubit>().state.pokedex.orderBy) {
        PokedexOrder.id => false,
        PokedexOrder.favorites => true
      };
}
