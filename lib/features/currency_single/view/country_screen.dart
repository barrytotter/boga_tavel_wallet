import 'package:auto_route/annotations.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:travel_wallet/features/currency_single/models/expense_category.dart';
import 'package:travel_wallet/features/currency_single/widgets/add_expense_dialog.dart';
import 'package:travel_wallet/generated/l10n.dart';
import '../../../repositories/travel_wallet/models/travel_wallet.dart';

@RoutePage()
class CountryScreen extends StatelessWidget {
  const CountryScreen({super.key, required this.travelWallet});

  final TravelWallet travelWallet;

  static List<ExpenseCategory> getExpenseCategories(BuildContext context) {
    final s = S.of(context);

    return [
      ExpenseCategory(
        key: 'food',
        name: s.food,
        icon: Icons.restaurant,
        color: Colors.orange,
      ),
      ExpenseCategory(
        key: 'transport',
        name: s.transport,
        icon: Icons.directions_car,
        color: Colors.blue,
      ),
      ExpenseCategory(
        key: 'housing',
        name: s.housing,
        icon: Icons.hotel,
        color: Colors.green,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currencyCode = travelWallet.abbreviation;

    return Scaffold(
      appBar: AppBar(),
      body: ValueListenableBuilder<Box<double>>(
        valueListenable: expenseStorage.listenable,
        builder: (context, box, child) {
          //достаём тотал по стране
          final totalSpentInCountry = expenseStorage.getTotalExpenses(
            currencyCode,
          );

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                elevation: 0,
                color: theme.colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.3,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        currencyCode,
                        style: theme.textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        S
                            .of(context)
                            .officialRateXXXByn(travelWallet.officialRate),
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              Card(
                elevation: 0,
                // Выделяем цветом контейнера, чтобы бросалось в глаза
                color: theme.colorScheme.primaryContainer.withValues(
                  alpha: 0.6,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.wallet_outlined,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                  title: Text(
                    S.of(context).totalSpent,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  trailing: Text(
                    '${totalSpentInCountry.toStringAsFixed(2)} $currencyCode',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              if (totalSpentInCountry > 0) ...[
                SizedBox(
                  height: 180,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 4,
                      centerSpaceRadius: 40,
                      sections: getExpenseCategories(context).map((category) {
                        final spentInCategory =
                            box.get('${currencyCode}_${category.key}') ?? 0.0;

                        final percentage =
                            (spentInCategory / totalSpentInCountry) * 100;

                        return PieChartSectionData(
                          value: spentInCategory,
                          color: category.color,
                          radius: 25,
                          // Показываем только если больше 5%
                          title: percentage > 5
                              ? '${percentage.toStringAsFixed(0)}%'
                              : '',
                          titleStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],

              // разобьём на категории
              Text(
                S.of(context).expenses,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.hintColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),

              // Генерируем список категорий на основе карты маппинга
              ...getExpenseCategories(context).map((category) {
                // значение по стране
                final spentInCategory =
                    box.get('${currencyCode}_${category.key}') ?? 0.0;

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: theme.colorScheme.primaryContainer,
                      child: Icon(
                        category.icon,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                    title: Text(
                      category.name,
                      style: theme.textTheme.titleMedium,
                    ),
                    trailing: Text(
                      '${spentInCategory.toStringAsFixed(2)} $currencyCode',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddExpenseDialog(context: context, travelWallet: travelWallet);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
