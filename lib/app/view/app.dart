import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/l10n/l10n.dart';
import 'package:flutter_pokedex/pokedex/pokedex.dart';
import 'package:pokedex_repository/pokedex_repository.dart';

class PokedexApp extends StatelessWidget {
  const PokedexApp({
    super.key,
    required PokedexRepository pokedexRepository,
  }) : _pokedexRepository = pokedexRepository;

  final PokedexRepository _pokedexRepository;

  @override
  Widget build(BuildContext context) => RepositoryProvider.value(
        value: _pokedexRepository,
        child: const PokedexAppView(),
      );
}

class PokedexAppView extends StatelessWidget {
  const PokedexAppView({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: PokemonsPage(),
        debugShowCheckedModeBanner: false,
      );
}
