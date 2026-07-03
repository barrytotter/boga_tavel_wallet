import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:travel_wallet/generated/l10n.dart';
import 'package:travel_wallet/repositories/travel_wallet/models/travel_wallet.dart';

class TotalExpensesCard extends StatelessWidget {
  const TotalExpensesCard({super.key, required this.wallets});

  final List<TravelWallet> wallets;

  int _getCurrencyScale(String abbreviation) {
    switch (abbreviation) {
      case 'USD':
        return 1;
      case 'EUR':
        return 1;
      case 'VND':
        return 10000;
      case 'JPY':
        return 100;
      case 'CNY':
        return 10;
      case 'KZT':
        return 100;
      default:
        return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ValueListenableBuilder<Box<double>>(
      valueListenable: Hive.box<double>('expenses_box').listenable(),
      builder: (context, box, child) {
        double totalByn = 0.0;

        for (final wallet in wallets) {
          final spentInCurrency = box.get(wallet.abbreviation) ?? 0.0;
          final scale = _getCurrencyScale(wallet.abbreviation);

          if (spentInCurrency > 0) {
            totalByn += (spentInCurrency / scale) * wallet.officialRate;
          }
        }
        return Card(
          margin: const EdgeInsets.all(16),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).totalTravelExpenses,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.hintColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Выводим общую сумму, округленную до 2 знаков
                    Text(
                      '${totalByn.toStringAsFixed(2)} BYN',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                      ),
                    ),
                    const Icon(Icons.analytics_outlined, size: 32),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
