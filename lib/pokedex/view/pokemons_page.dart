import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/pokedex/cubit/pokedex_cubit.dart';
import 'package:flutter_pokedex/pokedex/view/pokemons_list.dart';
import 'package:flutter_pokedex/pokedex/widgets/widgets.dart';
import 'package:pokedex_repository/pokedex_repository.dart';

class PokemonsPage extends StatelessWidget {
  const PokemonsPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => PokedexCubit(PokedexRepository())..getPokedex(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Pokédex'),
            actions: const [
              FavoriteOrder(),
            ],
          ),
          body: const PokemonsList(),
        ),
      );
}
