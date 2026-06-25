import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:get_it/get_it.dart';
import '../repositories/travel_wallet/models/travel_wallet.dart';
import '../features/currency_list/view/travel_wallet_screen.dart';
import '../features/currency_single/view/byn.dart';

part 'routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: TravelWalletRoute.page, path: '/'),
    AutoRoute(page: BynRoute.page, path: '/byn'),
    AutoRoute(page: TalkerRouteRoute.page, path: '/talker'),
  ];
}

@RoutePage()
class TalkerScreenPage extends StatelessWidget {
  const TalkerScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TalkerScreen(talker: GetIt.I<Talker>());
  }
}
