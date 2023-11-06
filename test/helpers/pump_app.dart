import 'package:flutter/material.dart';
import 'package:flutter_pokedex/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

extension PumpApp on WidgetTester {
  Future<AppLocalizations> pumpApp(Widget widget) async {
    late AppLocalizations appLocalizations;

    await pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (BuildContext context) {
            appLocalizations = AppLocalizations.of(context);

            return widget;
          },
        ),
      ),
    );

    await pump();

    return appLocalizations;
  }
}
