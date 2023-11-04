import 'package:deep_pick/deep_pick.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex_repository/src/models/models.dart';

class Pokedex with EquatableMixin {
  Pokedex({
    required this.total,
    required this.pokemons,
  });

  factory Pokedex.fromMap(Map<String, dynamic> map) =>
      Pokedex.fromPick(pick(map).required());

  factory Pokedex.fromJson(String json) =>
      Pokedex.fromPick(pickFromJson(json).required());

  factory Pokedex.fromPick(RequiredPick pick) => Pokedex(
        total: pick('total').asIntOrThrow(),
        pokemons: pick('pokemons').asListOrEmpty(Pokemon.fromPick),
      );

  final int total;
  final List<Pokemon> pokemons;

  Map<String, dynamic> toMap() => {
        'total': total,
        'pokemons': pokemons.map((pokemon) => pokemon.toMap()),
      };

  @override
  List<Object?> get props => [
        total,
        pokemons,
      ];
}
