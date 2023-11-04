import 'package:deep_pick/deep_pick.dart';
import 'package:equatable/equatable.dart';

class Pokemon with EquatableMixin {
  Pokemon({
    required this.id,
    required this.order,
    required this.name,
    required this.baseExperience,
    required this.height,
    required this.weight,
    required this.sprites,
    required this.stats,
    required this.types,
  });

  factory Pokemon.fromMap(Map<String, dynamic> map) =>
      Pokemon.fromPick(pick(map).required());

  factory Pokemon.fromJson(String json) =>
      Pokemon.fromPick(pickFromJson(json).required());

  factory Pokemon.fromPick(RequiredPick pick) => Pokemon(
        id: pick('id').asIntOrThrow(),
        order: pick('order').asIntOrThrow(),
        name: pick('name').asStringOrThrow(),
        baseExperience: pick('base_experience').asIntOrThrow(),
        height: pick('height').asIntOrThrow(),
        weight: pick('weight').asIntOrThrow(),
        sprites: Sprites.fromPick(pick('sprites').required()),
        stats: pick('stats').asListOrThrow(StatElement.fromPick),
        types: pick('types').asListOrThrow(Type.fromPick),
      );

  final int id;
  final int order;
  final String name;
  final int baseExperience;
  final int height;
  final int weight;
  final Sprites sprites;
  final List<StatElement> stats;
  final List<Type> types;

  @override
  List<Object?> get props => [
        id,
        order,
        name,
        baseExperience,
        height,
        weight,
        sprites,
        stats,
        types,
      ];
}

class Sprites with EquatableMixin {
  Sprites({
    required this.frontDefault,
    required this.other,
  });

  factory Sprites.fromPick(RequiredPick pick) => Sprites(
        frontDefault: pick('front_default').asStringOrThrow(),
        other: Other.fromPick(pick('other').required()),
      );

  final String frontDefault;
  final Other other;

  @override
  List<Object?> get props => [
        frontDefault,
        other,
      ];
}

class Other with EquatableMixin {
  Other({
    required this.officialArtwork,
  });

  factory Other.fromPick(RequiredPick pick) => Other(
        officialArtwork: OfficialArtwork.fromPick(
          pick('official-artwork').required(),
        ),
      );

  final OfficialArtwork officialArtwork;

  @override
  List<Object?> get props => [
        officialArtwork,
      ];
}

class OfficialArtwork with EquatableMixin {
  OfficialArtwork({
    required this.frontDefault,
  });

  factory OfficialArtwork.fromPick(RequiredPick pick) => OfficialArtwork(
        frontDefault: pick('front_default').asStringOrThrow(),
      );

  final String frontDefault;

  @override
  List<Object?> get props => [
        frontDefault,
      ];
}

class StatElement with EquatableMixin {
  StatElement({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  factory StatElement.fromPick(RequiredPick pick) => StatElement(
        baseStat: pick('base_stat').asIntOrThrow(),
        effort: pick('effort').asIntOrThrow(),
        stat: SimpleDescription.fromPick(pick('stat').required()),
      );

  final int baseStat;
  final int effort;
  final SimpleDescription stat;

  @override
  List<Object?> get props => [
        baseStat,
        effort,
        stat,
      ];
}

class SimpleDescription with EquatableMixin {
  SimpleDescription({
    required this.name,
  });

  factory SimpleDescription.fromPick(RequiredPick pick) => SimpleDescription(
        name: pick('name').asStringOrThrow(),
      );

  final String name;

  @override
  List<Object?> get props => [
        name,
      ];
}

class Type with EquatableMixin {
  Type({
    required this.slot,
    required this.type,
  });

  factory Type.fromPick(RequiredPick pick) => Type(
        slot: pick('slot').asIntOrThrow(),
        type: SimpleDescription.fromPick(pick('type').required()),
      );

  final int slot;
  final SimpleDescription type;

  @override
  List<Object?> get props => [
        slot,
        type,
      ];
}
