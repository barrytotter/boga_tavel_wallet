import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:travel_wallet/generated/l10n.dart';

import 'routes/routes.dart';
import 'theme/theme.dart';

class TravelWalletApp extends StatefulWidget {
  const TravelWalletApp({super.key});

  @override
  State<TravelWalletApp> createState() => _TravelWalletAppState();
}

class _TravelWalletAppState extends State<TravelWalletApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TravelWalletApp',
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale('en'),
      supportedLocales: S.delegate.supportedLocales,
      theme: darkTheme,
      routerConfig: _appRouter.config(
        navigatorObservers: () => [TalkerRouteObserver(GetIt.I<Talker>())],
      ),
    );
  }
}
