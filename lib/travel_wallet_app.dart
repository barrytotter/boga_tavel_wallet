import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

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
      theme: darkTheme,
      routerConfig: _appRouter.config(
        navigatorObservers: () => [
        TalkerRouteObserver(GetIt.I<Talker>(),
        ),
      ],
      ),
    );
  }
}