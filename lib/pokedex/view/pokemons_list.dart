import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/l10n/l10n.dart';
import 'package:flutter_pokedex/pokedex/cubit/pokedex_cubit.dart';
import 'package:flutter_pokedex/pokedex/widgets/widgets.dart';

class PokemonsList extends StatefulWidget {
  const PokemonsList({super.key});

  @override
  State<PokemonsList> createState() => _PokemonsListState();
}

class _PokemonsListState extends State<PokemonsList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<PokedexCubit, PokedexState>(
        builder: (context, state) {
          switch (state.status) {
            case PokedexStatus.failure:
              return Center(
                child: Text(
                  context.l10n.pokedexFailedToFetchPokemons,
                ),
              );
            case PokedexStatus.success:
              if (state.pokedex.pokemons.isEmpty) {
                return Center(
                  child: Text(
                    context.l10n.pokedexNoPokemonFound,
                  ),
                );
              } else {
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) => index >=
                          state.pokedex.pokemons.length
                      ? const BottomLoader()
                      : PokemonListItem(pokemon: state.pokedex.pokemons[index]),
                  itemCount: state.pokedex.completed
                      ? state.pokedex.pokemons.length
                      : state.pokedex.pokemons.length + 1,
                  controller: _scrollController,
                );
              }
            case PokedexStatus.initial:
            case PokedexStatus.loading:
              return const Center(child: CircularProgressIndicator());
          }
        },
      );

  void _onScroll() {
    if (_isBottom) context.read<PokedexCubit>().loadMore();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;

    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();

    super.dispose();
  }
}
