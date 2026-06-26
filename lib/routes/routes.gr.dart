// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'routes.dart';

/// generated route for
/// [CountryScreen]
class CountryRoute extends PageRouteInfo<CountryRouteArgs> {
  CountryRoute({
    Key? key,
    required TravelWallet travelWallet,
    List<PageRouteInfo>? children,
  }) : super(
         CountryRoute.name,
         args: CountryRouteArgs(key: key, travelWallet: travelWallet),
         initialChildren: children,
       );

  static const String name = 'CountryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CountryRouteArgs>();
      return CountryScreen(key: args.key, travelWallet: args.travelWallet);
    },
  );
}

class CountryRouteArgs {
  const CountryRouteArgs({this.key, required this.travelWallet});

  final Key? key;

  final TravelWallet travelWallet;

  @override
  String toString() {
    return 'CountryRouteArgs{key: $key, travelWallet: $travelWallet}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CountryRouteArgs) return false;
    return key == other.key && travelWallet == other.travelWallet;
  }

  @override
  int get hashCode => key.hashCode ^ travelWallet.hashCode;
}

/// generated route for
/// [TalkerScreenPage]
class TalkerRouteRoute extends PageRouteInfo<void> {
  const TalkerRouteRoute({List<PageRouteInfo>? children})
    : super(TalkerRouteRoute.name, initialChildren: children);

  static const String name = 'TalkerRouteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TalkerScreenPage();
    },
  );
}

/// generated route for
/// [TravelWalletScreen]
class TravelWalletRoute extends PageRouteInfo<TravelWalletRouteArgs> {
  TravelWalletRoute({
    Key? key,
    String title = 'Travel Wallet',
    List<PageRouteInfo>? children,
  }) : super(
         TravelWalletRoute.name,
         args: TravelWalletRouteArgs(key: key, title: title),
         initialChildren: children,
       );

  static const String name = 'TravelWalletRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TravelWalletRouteArgs>(
        orElse: () => const TravelWalletRouteArgs(),
      );
      return TravelWalletScreen(key: args.key, title: args.title);
    },
  );
}

class TravelWalletRouteArgs {
  const TravelWalletRouteArgs({this.key, this.title = 'Travel Wallet'});

  final Key? key;

  final String title;

  @override
  String toString() {
    return 'TravelWalletRouteArgs{key: $key, title: $title}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TravelWalletRouteArgs) return false;
    return key == other.key && title == other.title;
  }

  @override
  int get hashCode => key.hashCode ^ title.hashCode;
}
