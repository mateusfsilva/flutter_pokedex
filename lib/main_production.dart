import 'package:flutter/material.dart';
import 'package:flutter_pokedex/app/app.dart';
import 'package:flutter_pokedex/bootstrap.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pokedex_repository/pokedex_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  bootstrap(() => PokedexApp(pokedexRepository: PokedexRepository()));
}
