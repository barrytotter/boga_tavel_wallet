import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:travel_wallet/features/currency_single/widgets/add_expense_dialog.dart';
import 'package:travel_wallet/generated/l10n.dart';
import 'package:travel_wallet/routes/routes.dart';
import 'package:travel_wallet/repositories/travel_wallet/models/travel_wallet.dart';

class CurrencyListTile extends StatelessWidget {
  const CurrencyListTile({super.key, required this.travelWallet});

  final TravelWallet travelWallet;

  static const Map<String, ({String flag, int scale})> _currencyData = {
    'USD': (flag: '🇺🇸', scale: 1),
    'EUR': (flag: '🇪🇺', scale: 1),
    'VND': (flag: '🇻🇳', scale: 10000),
    'JPY': (flag: '🇯🇵', scale: 100),
    'CNY': (flag: '🇨🇳', scale: 10),
    'KZT': (flag: '🇰🇿', scale: 100),
  };

  static String countryName(BuildContext context, String code) {
    final s = S.of(context);

    return switch (code) {
      'USD' => s.USA,
      'EUR' => s.EU,
      'VND' => s.vietnam,
      'JPY' => s.japan,
      'CNY' => s.china,
      'KZT' => s.kazahstan,
      _ => code,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currencyInfo =
        _currencyData[travelWallet.abbreviation] ?? (flag: '🏳️', scale: 1);

    return ListTile(
      leading: Text(
        currencyInfo.flag,
        style: const TextStyle(
          fontSize: 28,
        ), // Чтобы флаг был крупным и красивым
      ),
      title: Text(
        countryName(context, travelWallet.abbreviation),
        style: theme.textTheme.bodyMedium,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${currencyInfo.scale} ${travelWallet.abbreviation} = ${travelWallet.officialRate} BYN',
            style: theme.textTheme.labelSmall,
          ),
          const SizedBox(height: 4),
          ValueListenableBuilder<Box<double>>(
            valueListenable: expenseStorage.listenable,
            builder: (context, box, child) {
              final spent = box.get(travelWallet.abbreviation) ?? 0.0;
              return Text(
                S
                    .of(context)
                    .spentInXXXCurr(
                      spent.toStringAsFixed(2),
                      travelWallet.abbreviation,
                    ),
                // 'Потрачено: ${spent.toStringAsFixed(2)} ${travelWallet.abbreviation}',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.hintColor, // текст чуть приглушенным
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ],
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: theme.dividerColor,
        size: 16,
      ),
      onTap: () {
        AutoRouter.of(context).push(CountryRoute(travelWallet: travelWallet));
      },
    );
  }
}
