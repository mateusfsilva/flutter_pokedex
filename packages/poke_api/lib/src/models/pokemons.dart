import 'package:deep_pick/deep_pick.dart';
import 'package:equatable/equatable.dart';

class Pokemons with EquatableMixin {
  Pokemons({
    required this.count,
    this.next,
    this.previous,
    required this.pokemons,
  });

  factory Pokemons.fromMap(Map<String, dynamic> map) =>
      Pokemons.fromPick(pick(map).required());

  factory Pokemons.fromJson(String json) => Pokemons.fromPick(
        pickFromJson(json).required(),
      );

  factory Pokemons.fromPick(RequiredPick pick) => Pokemons(
        count: pick('count').asIntOrThrow(),
        next: pick('next').asStringOrNull(),
        previous: pick('previous').asStringOrNull(),
        pokemons: pick('results').asListOrEmpty(PokemonAddress.fromPick),
      );

  final int count;
  final String? next;
  final String? previous;
  final List<PokemonAddress> pokemons;

  @override
  List<Object?> get props => [
        count,
        next,
        previous,
        pokemons,
      ];
}

class PokemonAddress with EquatableMixin {
  PokemonAddress({
    required this.name,
    required this.url,
  });

  factory PokemonAddress.fromPick(RequiredPick pick) => PokemonAddress(
        name: pick('name').asStringOrThrow(),
        url: pick('url').asStringOrThrow(),
      );

  final String name;
  final String url;

  @override
  List<Object?> get props => [
        name,
        url,
      ];
}
