import 'package:deep_pick/deep_pick.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_pokedex/pokedex/models/pokemon.dart';
import 'package:pokedex_repository/pokedex_repository.dart'
    as pokedex_repository;

class Pokedex with EquatableMixin {
  Pokedex({
    required this.orderBy,
    required this.completed,
    required this.pokemons,
  });

  factory Pokedex.empty() => Pokedex(
        orderBy: PokedexOrder.id,
        completed: false,
        pokemons: [],
      );

  factory Pokedex.fromMap(Map<String, dynamic> map) =>
      Pokedex.fromPick(pick(map).required());

  factory Pokedex.fromJson(String json) =>
      Pokedex.fromPick(pickFromJson(json).required());

  factory Pokedex.fromPick(RequiredPick pick) => Pokedex(
        orderBy: PokedexOrder.values[pick('order_by').asIntOrThrow()],
        completed: pick('completed').asBoolOrThrow(),
        pokemons: pick('pokemons').asListOrEmpty(Pokemon.fromPick),
      );

  factory Pokedex.fromRepository(pokedex_repository.Pokedex pokedex) =>
      Pokedex.empty().copyWith(
        pokemons: pokedex.pokemons.map(Pokemon.fromRepository).toList(),
      );

  final PokedexOrder orderBy;
  final bool completed;
  final List<Pokemon> pokemons;

  Map<String, dynamic> toMap() => {
        'order_by': orderBy.index,
        'completed': completed,
        'pokemons': pokemons.map((pokemon) => pokemon.toMap()).toList(),
      };

  Pokedex copyWith({
    PokedexOrder? orderBy,
    bool? completed,
    List<Pokemon>? pokemons,
  }) =>
      Pokedex(
        orderBy: orderBy ?? this.orderBy,
        completed: completed ?? this.completed,
        pokemons: pokemons ?? this.pokemons,
      );

  @override
  List<Object?> get props => [
        orderBy,
        completed,
        pokemons,
      ];
}

enum PokedexOrder {
  id,
  favorites,
}
