import 'dart:convert' show jsonEncode;

import 'package:poke_api/src/models/pokemon.dart';
import 'package:test/test.dart';

void main() {
  const id = 1;
  const order = 1;
  const name = 'bulbasaur';
  const baseExperience = 64;
  const type01 = 'grass';
  const type02 = 'poison';
  const height = 7;
  const weight = 69;
  const hpStatName = 'hp';
  const hp = 45;
  const attackStatName = 'attack';
  const attack = 49;
  const defenseStatName = 'defense';
  const defense = 49;
  const specialAttackStatName = 'special-attack';
  const specialAttack = 65;
  const specialDefenseStatName = 'special-defense';
  const specialDefense = 65;
  const speedStatName = 'speed';
  const speed = 45;
  const icon =
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png';
  const sprite =
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png';
  const pokemonMap = <String, dynamic>{
    'abilities': [],
    'base_experience': baseExperience,
    'forms': [],
    'game_indices': [],
    'height': height,
    'held_items': [],
    'id': id,
    'is_default': true,
    'location_area_encounters':
        'https://pokeapi.co/api/v2/pokemon/1/encounters',
    'moves': [],
    'name': name,
    'order': order,
    'past_abilities': [],
    'past_types': [],
    'species': {},
    'sprites': {
      'back_default':
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/1.png',
      'back_female': null,
      'back_shiny':
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/1.png',
      'back_shiny_female': null,
      'front_default':
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
      'front_female': null,
      'front_shiny':
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png',
      'front_shiny_female': null,
      'other': {
        'dream_world': {
          'front_default':
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/1.svg',
          'front_female': null,
        },
        'home': {
          'front_default':
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png',
          'front_female': null,
          'front_shiny':
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/shiny/1.png',
          'front_shiny_female': null,
        },
        'official-artwork': {
          'front_default': sprite,
          'front_shiny':
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/1.png',
        },
      },
      'versions': {},
    },
    'stats': [
      {
        'base_stat': hp,
        'effort': 0,
        'stat': {
          'name': hpStatName,
          'url': 'https://pokeapi.co/api/v2/stat/1/',
        },
      },
      {
        'base_stat': attack,
        'effort': 0,
        'stat': {
          'name': attackStatName,
          'url': 'https://pokeapi.co/api/v2/stat/2/',
        },
      },
      {
        'base_stat': defense,
        'effort': 0,
        'stat': {
          'name': defenseStatName,
          'url': 'https://pokeapi.co/api/v2/stat/3/',
        },
      },
      {
        'base_stat': specialAttack,
        'effort': 1,
        'stat': {
          'name': specialAttackStatName,
          'url': 'https://pokeapi.co/api/v2/stat/4/',
        },
      },
      {
        'base_stat': specialDefense,
        'effort': 0,
        'stat': {
          'name': specialDefenseStatName,
          'url': 'https://pokeapi.co/api/v2/stat/5/',
        },
      },
      {
        'base_stat': speed,
        'effort': 0,
        'stat': {
          'name': speedStatName,
          'url': 'https://pokeapi.co/api/v2/stat/6/',
        },
      }
    ],
    'types': [
      {
        'slot': 1,
        'type': {'name': type01, 'url': 'https://pokeapi.co/api/v2/type/12/'},
      },
      {
        'slot': 2,
        'type': {'name': type02, 'url': 'https://pokeapi.co/api/v2/type/4/'},
      }
    ],
    'weight': weight,
  };

  final types = [
    Type(slot: 1, type: SimpleDescription(name: type01)),
    Type(slot: 2, type: SimpleDescription(name: type02)),
  ];
  final hpStat = StatElement(
    baseStat: hp,
    effort: 0,
    stat: SimpleDescription(name: hpStatName),
  );
  final attackStat = StatElement(
    baseStat: attack,
    effort: 0,
    stat: SimpleDescription(name: attackStatName),
  );
  final defenseStat = StatElement(
    baseStat: defense,
    effort: 0,
    stat: SimpleDescription(name: defenseStatName),
  );
  final specialAttackStat = StatElement(
    baseStat: specialAttack,
    effort: 1,
    stat: SimpleDescription(name: specialAttackStatName),
  );
  final specialDefenseStat = StatElement(
    baseStat: specialDefense,
    effort: 0,
    stat: SimpleDescription(name: specialDefenseStatName),
  );
  final speedStat = StatElement(
    baseStat: speed,
    effort: 0,
    stat: SimpleDescription(name: speedStatName),
  );
  final stats = [
    hpStat,
    attackStat,
    defenseStat,
    specialAttackStat,
    specialDefenseStat,
    speedStat,
  ];

  test('Test the default initializer', () {
    final pokemon01 = Pokemon(
      id: id,
      order: order,
      name: name,
      baseExperience: baseExperience,
      types: types,
      height: height,
      weight: weight,
      stats: stats,
      sprites: Sprites(
        frontDefault: icon,
        other: Other(
          officialArtwork: OfficialArtwork(frontDefault: sprite),
        ),
      ),
    );

    expect(pokemon01.id, id);
    expect(pokemon01.order, order);
    expect(pokemon01.name, name);
    expect(pokemon01.baseExperience, baseExperience);
    expect(pokemon01.types.length, 2);
    expect(pokemon01.types[0].type.name, type01);
    expect(pokemon01.types[1].type.name, type02);
    expect(pokemon01.height, height);
    expect(pokemon01.weight, weight);
    expect(
      pokemon01.stats.where((s) => s.stat.name == hpStatName).first.baseStat,
      hp,
    );
    expect(
      pokemon01.stats
          .where((s) => s.stat.name == attackStatName)
          .first
          .baseStat,
      attack,
    );
    expect(
      pokemon01.stats
          .where((s) => s.stat.name == defenseStatName)
          .first
          .baseStat,
      defense,
    );
    expect(
      pokemon01.stats
          .where((s) => s.stat.name == specialAttackStatName)
          .first
          .baseStat,
      specialAttack,
    );
    expect(
      pokemon01.stats
          .where((s) => s.stat.name == specialDefenseStatName)
          .first
          .baseStat,
      specialDefense,
    );
    expect(
      pokemon01.stats.where((s) => s.stat.name == speedStatName).first.baseStat,
      speed,
    );
    expect(pokemon01.sprites.frontDefault, icon);
    expect(pokemon01.sprites.other.officialArtwork.frontDefault, sprite);
  });

  test('Test initialize from a map', () {
    final pokemon01 = Pokemon(
      id: id,
      order: order,
      name: name,
      baseExperience: baseExperience,
      types: types,
      height: height,
      weight: weight,
      stats: stats,
      sprites: Sprites(
        frontDefault: icon,
        other: Other(
          officialArtwork: OfficialArtwork(frontDefault: sprite),
        ),
      ),
    );
    final pokemon02 = Pokemon.fromMap(pokemonMap);

    expect(pokemon01, equals(pokemon02));
  });

  test('Test initialize from a json', () {
    final pokemon01 = Pokemon(
      id: id,
      order: order,
      name: name,
      baseExperience: baseExperience,
      types: types,
      height: height,
      weight: weight,
      stats: stats,
      sprites: Sprites(
        frontDefault: icon,
        other: Other(
          officialArtwork: OfficialArtwork(frontDefault: sprite),
        ),
      ),
    );
    final pokemon02 = Pokemon.fromJson(jsonEncode(pokemonMap));

    expect(pokemon01, equals(pokemon02));
  });
}
