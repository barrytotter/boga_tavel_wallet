import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_wallet/routes/routes.dart';
import '../../../repositories/travel_wallet/models/travel_wallet.dart';

class CurrencyListTile extends StatelessWidget {
  const CurrencyListTile({
    super.key,
    required this.travelWallet,
  });

  final TravelWallet travelWallet;

  String getCurrencyIcon(String abbreviation) {
  switch (abbreviation) {
    case 'USD':
      return 'assets/svg/usd.svg';
    case 'EUR':
      return 'assets/svg/eur.svg';
    case 'CNY':
      return 'assets/svg/cny.svg';
    case 'JPY':
      return 'assets/svg/jpy.svg';
    case 'KZT':
      return 'assets/svg/kzt.svg';
    case 'VND':
      return 'assets/svg/vnd.svg';
    default:
      return 'assets/svg/byn_logo.svg';
  }
}

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: SvgPicture.asset(
        getCurrencyIcon(travelWallet.abbreviation),
        width: 25,
        height: 25,
      ),
    title: Text(
      travelWallet.name,
      style: theme.textTheme.bodyMedium,
    ),
    subtitle: Text(
      'Курс: ${travelWallet.officialRate}',
      style: theme.textTheme.labelSmall,
    ),
    trailing: Icon(Icons.arrow_forward_ios, color: theme.dividerColor),
    onTap: () {
      AutoRouter.of(context).push(BynRoute(travelWallet: travelWallet));
      // Navigator.pushNamed(context, '/byn', arguments: travelWallet);  
    },
            );
  }
}