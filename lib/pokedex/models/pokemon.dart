import 'package:deep_pick/deep_pick.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex_repository/pokedex_repository.dart'
    as pokedex_repository;

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
    required this.favorite,
  });

  factory Pokemon.fromMap(Map<String, dynamic> map) =>
      Pokemon.fromPick(pick(map).required());

  factory Pokemon.fromJson(String json) =>
      Pokemon.fromPick(pickFromJson(json).required());

  factory Pokemon.fromPick(RequiredPick pick) => Pokemon(
        id: pick('id').asIntOrThrow(),
        name: pick('name').asStringOrThrow(),
        types: pick('types').asListOrThrow(
          (pick) => PokemonType.values[pick.asIntOrThrow()],
        ),
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
        favorite: pick('favorite').asBoolOrThrow(),
      );

  factory Pokemon.fromRepository(pokedex_repository.Pokemon pokemon) => Pokemon(
        id: pokemon.id,
        name: pokemon.name,
        types: pokemon.types.map(getTypeFromRepository).toList(),
        height: pokemon.height,
        weight: pokemon.weight,
        hp: pokemon.hp,
        attack: pokemon.attack,
        defense: pokemon.defense,
        specialAttack: pokemon.specialAttack,
        specialDefense: pokemon.specialDefense,
        speed: pokemon.speed,
        icon: pokemon.icon,
        sprite: pokemon.sprite,
        favorite: false,
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
  final bool favorite;

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'types': types.map((type) => type.index).toList(),
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
        'favorite': favorite,
      };

  Pokemon copyWith({
    int? id,
    String? name,
    List<PokemonType>? types,
    int? height,
    int? weight,
    int? hp,
    int? attack,
    int? defense,
    int? specialAttack,
    int? specialDefense,
    int? speed,
    String? icon,
    String? sprite,
    bool? favorite,
  }) =>
      Pokemon(
        id: id ?? this.id,
        name: name ?? this.name,
        types: types ?? this.types,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        hp: hp ?? this.hp,
        attack: attack ?? this.attack,
        defense: defense ?? this.defense,
        specialAttack: specialAttack ?? this.specialAttack,
        specialDefense: specialDefense ?? this.specialDefense,
        speed: speed ?? this.speed,
        icon: icon ?? this.icon,
        sprite: sprite ?? this.sprite,
        favorite: favorite ?? this.favorite,
      );

  static PokemonType getTypeFromRepository(
    pokedex_repository.PokemonType type,
  ) {
    switch (type) {
      case pokedex_repository.PokemonType.normal:
        return PokemonType.normal;
      case pokedex_repository.PokemonType.fighting:
        return PokemonType.fighting;
      case pokedex_repository.PokemonType.flying:
        return PokemonType.flying;
      case pokedex_repository.PokemonType.poison:
        return PokemonType.poison;
      case pokedex_repository.PokemonType.ground:
        return PokemonType.ground;
      case pokedex_repository.PokemonType.rock:
        return PokemonType.rock;
      case pokedex_repository.PokemonType.bug:
        return PokemonType.bug;
      case pokedex_repository.PokemonType.ghost:
        return PokemonType.ghost;
      case pokedex_repository.PokemonType.steel:
        return PokemonType.steel;
      case pokedex_repository.PokemonType.fire:
        return PokemonType.fire;
      case pokedex_repository.PokemonType.water:
        return PokemonType.water;
      case pokedex_repository.PokemonType.grass:
        return PokemonType.grass;
      case pokedex_repository.PokemonType.electric:
        return PokemonType.electric;
      case pokedex_repository.PokemonType.psychic:
        return PokemonType.psychic;
      case pokedex_repository.PokemonType.ice:
        return PokemonType.ice;
      case pokedex_repository.PokemonType.dragon:
        return PokemonType.dragon;
      case pokedex_repository.PokemonType.dark:
        return PokemonType.dark;
      case pokedex_repository.PokemonType.fairy:
        return PokemonType.fairy;
      case pokedex_repository.PokemonType.unknown:
        return PokemonType.unknown;
      case pokedex_repository.PokemonType.shadow:
        return PokemonType.shadow;
    }
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
        icon,
        sprite,
        favorite,
      ];
}

enum PokemonType {
  normal,
  fighting,
  flying,
  poison,
  ground,
  rock,
  bug,
  ghost,
  steel,
  fire,
  water,
  grass,
  electric,
  psychic,
  ice,
  dragon,
  dark,
  fairy,
  unknown,
  shadow;
}
