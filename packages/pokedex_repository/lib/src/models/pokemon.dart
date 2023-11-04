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
    required this.icon,
    required this.sprite,
  });

  factory Pokemon.fromMap(Map<String, dynamic> map) =>
      Pokemon.fromPick(pick(map).required());

  factory Pokemon.fromJson(String json) =>
      Pokemon.fromPick(pickFromJson(json).required());

  factory Pokemon.fromPick(RequiredPick pick) => Pokemon(
        id: pick('id').asIntOrThrow(),
        name: pick('name').asStringOrThrow(),
        types: pick('types').asListOrThrow(PokemonType.fromPick),
        height: pick('height').asIntOrThrow(),
        weight: pick('weight').asIntOrThrow(),
        hp: pick('hp').asIntOrThrow(),
        attack: pick('attack').asIntOrThrow(),
        defense: pick('defense').asIntOrThrow(),
        specialAttack: pick('special_attack').asIntOrThrow(),
        specialDefense: pick('special_defense').asIntOrThrow(),
        speed: pick('speed').asIntOrThrow(),
        icon: pick('icon').asStringOrThrow(),
        sprite: pick('sprite').asStringOrThrow(),
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
  final String icon;
  final String sprite;

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'types': types.map((type) => type.value),
        'height': height,
        'weight': weight,
        'hp': hp,
        'attack': attack,
        'defense': defense,
        'special_attack': specialAttack,
        'special_defense': specialDefense,
        'speed': speed,
        'icon': icon,
        'sprite': sprite,
      };

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
        icon,
        sprite,
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

  factory PokemonType.fromPick(RequiredPick pick) =>
      PokemonType.fromValue(pick.asStringOrThrow());

  factory PokemonType.fromValue(String value) => PokemonType.values.firstWhere(
        (type) => type.value == value,
        orElse: () => PokemonType.unknown,
      );
}
