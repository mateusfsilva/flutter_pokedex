import 'package:deep_pick/deep_pick.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_pokedex/pokedex/models/models.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:pokedex_repository/pokedex_repository.dart'
    show PokedexRepository;

part 'pokedex_state.dart';

class PokedexCubit extends HydratedCubit<PokedexState> {
  PokedexCubit(this._pokedexRepository) : super(PokedexState());

  final PokedexRepository _pokedexRepository;

  /// Get the Pokedex from the repository.
  Future<void> getPokedex() async {
    if (state.pokedex.pokemons.isNotEmpty) {
      loadMore();

      return;
    }

    emit(state.copyWith(status: PokedexStatus.loading));

    try {
      final pokedex = Pokedex.fromRepository(
        await _pokedexRepository.getPokemons(
          offset: state.pokedex.pokemons.length,
        ),
      );

      pokedex.pokemons.sort(_sortByID);

      emit(
        state.copyWith(
          status: PokedexStatus.success,
          pokedex: pokedex,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: PokedexStatus.failure));
    }
  }

  /// Load more Pokemons into the Pokedex.
  Future<void> loadMore() async {
    if (!state.status.isSuccess) return;

    emit(state.copyWith(status: PokedexStatus.loadingMore));

    try {
      final result = await _pokedexRepository.getPokemons(
        offset: state.pokedex.pokemons.length,
        limit: 10,
      );
      final totalPokemons = result.total;
      final pokedex = Pokedex.fromRepository(result);
      final pokemons = List<Pokemon>.from(state.pokedex.pokemons)
        ..addAll(pokedex.pokemons);

      pokemons.unique((pokemon) => pokemon.id);

      if (state.pokedex.orderBy == PokedexOrder.favorites) {
        pokemons.sort(_sortByFavorites);
      } else {
        pokemons.sort(_sortByID);
      }

      emit(
        state.copyWith(
          status: PokedexStatus.success,
          pokedex: state.pokedex.copyWith(
            completed: pokemons.length == totalPokemons,
            pokemons: pokemons,
          ),
        ),
      );
    } on Exception {
      emit(state);
    }
  }

  /// Change the order of the Pokemons.
  Future<void> orderBy(PokedexOrder order) async {
    final pokemons = List<Pokemon>.from(state.pokedex.pokemons);

    if (order == PokedexOrder.favorites) {
      pokemons.sort(_sortByFavorites);
    } else {
      pokemons.sort(_sortByID);
    }

    emit(
      state.copyWith(
        pokedex: state.pokedex.copyWith(
          orderBy: order,
          pokemons: pokemons,
        ),
      ),
    );
  }

  /// Mark/Dismark a Pokemon as a favorite.
  Future<void> toggleFavorite({
    required int pokemonID,
  }) async {
    final pokemons = List<Pokemon>.from(state.pokedex.pokemons);
    final pokemonIndex = pokemons.indexWhere(
      (pokemon) => pokemon.id == pokemonID,
    );

    if (pokemonIndex == -1) {
      emit(state);
    } else {
      final pokemon = pokemons[pokemonIndex];

      pokemons[pokemonIndex] = pokemon.copyWith(favorite: !pokemon.favorite);

      if (state.pokedex.orderBy == PokedexOrder.favorites) {
        pokemons.sort(_sortByFavorites);
      } else {
        pokemons.sort(_sortByID);
      }

      emit(
        PokedexState(
          status: state.status,
          pokedex: Pokedex(
            orderBy: state.pokedex.orderBy,
            completed: state.pokedex.completed,
            pokemons: pokemons,
          ),
        ),
      );
    }
  }

  /// Sort the Pokemons by ID.
  int _sortByID(Pokemon p1, Pokemon p2) => p1.id.compareTo(p2.id);

  /// Sort the Pokemons by favorites.
  int _sortByFavorites(Pokemon p1, Pokemon p2) {
    if (!p1.favorite && p2.favorite) return 1;
    if (p1.favorite && !p2.favorite) return -1;

    return _sortByID(p1, p2);
  }

  @override
  PokedexState? fromJson(Map<String, dynamic> json) =>
      PokedexState.fromMap(json);

  @override
  Map<String, dynamic>? toJson(PokedexState state) => state.toMap();
}

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = <dynamic>{};

    final list = inplace ? this : List<E>.from(this);

    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));

    return list;
  }
}
