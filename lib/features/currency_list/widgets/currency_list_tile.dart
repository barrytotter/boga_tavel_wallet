import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:travel_wallet/routes/routes.dart';
import '../../../repositories/travel_wallet/models/travel_wallet.dart';

class CurrencyListTile extends StatelessWidget {
  const CurrencyListTile({super.key, required this.travelWallet});

  final TravelWallet travelWallet;

  static const Map<String, ({String flag, String country, int scale})>
  _currencyData = {
    'USD': (flag: '🇺🇸', country: 'США', scale: 1),
    'EUR': (flag: '🇪🇺', country: 'Еврозона', scale: 1),
    'VND': (flag: '🇻🇳', country: 'Вьетнам', scale: 10000),
    'JPY': (flag: '🇯🇵', country: 'Япония', scale: 100),
    'CNY': (flag: '🇨🇳', country: 'Китай', scale: 10),
    'KZT': (flag: '🇰🇿', country: 'Казахстан', scale: 100),
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currencyInfo =
        _currencyData[travelWallet.abbreviation] ??
        (flag: '🏳️', country: travelWallet.name, scale: 1);

    return ListTile(
      leading: Text(
        currencyInfo.flag,
        style: const TextStyle(
          fontSize: 28,
        ), // Чтобы флаг был крупным и красивым
      ),
      title: Text(currencyInfo.country, style: theme.textTheme.bodyMedium),
      subtitle: Text(
        '${currencyInfo.scale} ${travelWallet.abbreviation} = ${travelWallet.officialRate} BYN',
        style: theme.textTheme.labelSmall,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: theme.dividerColor,
        size: 16,
      ),
      onTap: () {
        AutoRouter.of(context).push(BynRoute(travelWallet: travelWallet));
      },
    );
  }
}
