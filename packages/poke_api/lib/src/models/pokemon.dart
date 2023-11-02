import 'dart:convert' show jsonDecode;

import 'package:deep_pick/deep_pick.dart';
import 'package:equatable/equatable.dart';

class Pokemon with EquatableMixin {
  Pokemon({
    required this.id,
    required this.name,
    required this.types,
    required this.height,
    required this.weight,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.specialAttack,
    required this.specialDefense,
    required this.speed,
    required this.sprite,
  });

  factory Pokemon.fromMap(Map<String, dynamic> map) =>
      Pokemon.fromPick(pick(map).required());

  factory Pokemon.fromJson(String json) => Pokemon.fromMap(
        jsonDecode(json) as Map<String, dynamic>,
      );

  factory Pokemon.fromPick(RequiredPick pick) => Pokemon(
        id: pick('id').asIntOrThrow(),
        name: pick('name').asStringOrThrow(),
        types: pick('types').asListOrThrow(
          (pick) => PokemonType.fromValue(
            pick('type')('name').asStringOrThrow(),
          ),
        ),
        height: pick('height').asIntOrThrow(),
        weight: pick('weight').asIntOrThrow(),
        hp: pick('stats').letOrThrow(
          (pick) => _getStats(pick, stat: 'hp'),
        ),
        attack: pick('stats').letOrThrow(
          (pick) => _getStats(pick, stat: 'attack'),
        ),
        defense: pick('stats').letOrThrow(
          (pick) => _getStats(pick, stat: 'defense'),
        ),
        specialAttack: pick('stats').letOrThrow(
          (pick) => _getStats(pick, stat: 'special-attack'),
        ),
        specialDefense: pick('stats').letOrThrow(
          (pick) => _getStats(pick, stat: 'special-defense'),
        ),
        speed: pick('stats').letOrThrow(
          (pick) => _getStats(pick, stat: 'speed'),
        ),
        sprite: pick('sprites')('other')('official-artwork')('front_default')
            .asStringOrThrow(),
      );

  final int id;
  final String name;
  final List<PokemonType> types;
  final int height;
  final int weight;
  final int hp;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;
  final int speed;
  final String sprite;

  static int _getStats(
    RequiredPick pick, {
    required String stat,
  }) {
    int value = 0;

    pick.asListOrThrow((p) {
      if (p('stat')('name').asStringOrThrow() == stat) {
        value = p('base_stat').asIntOrThrow();
      }
    });

    return value;
  }

  @override
  List<Object?> get props => [
        id,
        name,
        types,
        height,
        weight,
        hp,
        attack,
        defense,
        specialAttack,
        specialDefense,
        speed,
      ];
}

enum PokemonType {
  normal('normal'),
  fighting('fighting'),
  flying('flying'),
  poison('poison'),
  ground('ground'),
  rock('rock'),
  bug('bug'),
  ghost('ghost'),
  steel('steel'),
  fire('fire'),
  water('water'),
  grass('grass'),
  electric('electric'),
  psychic('psychic'),
  ice('ice'),
  dragon('dragon'),
  dark('dark'),
  fairy('fairy'),
  unknown('unknown'),
  shadow('shadow');

  const PokemonType(this.value);

  final String value;

  factory PokemonType.fromValue(String value) => PokemonType.values.firstWhere(
        (type) => type.value == value,
        orElse: () => PokemonType.unknown,
      );
}
