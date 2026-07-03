import 'package:auto_route/annotations.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:travel_wallet/generated/l10n.dart';
import '../../../repositories/travel_wallet/models/travel_wallet.dart';

@RoutePage()
class CountryScreen extends StatelessWidget {
  const CountryScreen({super.key, required this.travelWallet});

  final TravelWallet travelWallet;

  static Map<String, (String, IconData, Color)> categories(
    BuildContext context,
  ) {
    final s = S.of(context);

    return {
      'food': (s.food, Icons.restaurant, Colors.orange),
      'transport': (s.transport, Icons.directions_car, Colors.blue),
      'housing': (s.housing, Icons.hotel, Colors.green),
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final abbr = travelWallet.abbreviation;

    return Scaffold(
      appBar: AppBar(),
      body: ValueListenableBuilder<Box<double>>(
        valueListenable: Hive.box<double>('expenses_box').listenable(),
        builder: (context, box, child) {
          //достаём тотал по стране
          final totalSpentInCountry = box.get(abbr) ?? 0.0;

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
                        abbr,
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
                    '${totalSpentInCountry.toStringAsFixed(2)} $abbr',
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
                      sections: categories(context).entries.map((entry) {
                        final catKey = entry.key;
                        final color = entry.value.$3;
                        final spentInCategory =
                            box.get('${abbr}_$catKey') ?? 0.0;

                        final percentage =
                            (spentInCategory / totalSpentInCountry) * 100;

                        return PieChartSectionData(
                          value: spentInCategory,
                          color: color,
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
              ...categories(context).entries.map((entry) {
                final catKey = entry.key;
                final (catName, catIcon, catColor) = entry.value;
                // значение по стране
                final spentInCategory = box.get('${abbr}_$catKey') ?? 0.0;

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: theme.colorScheme.primaryContainer,
                      child: Icon(
                        catIcon,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                    title: Text(catName, style: theme.textTheme.titleMedium),
                    trailing: Text(
                      '${spentInCategory.toStringAsFixed(2)} $abbr',
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
        onPressed: () => _showAddExpenseDialog(context),
        child: const Icon(Icons.add_card),
      ),
    );
  }

  void _showAddExpenseDialog(BuildContext context) {
    final amountController = TextEditingController();

    String selectedCategory = categories(context).keys.first;

    bool isAddition = true;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(
                isAddition
                    ? S.of(context).abbreviation(travelWallet.abbreviation)
                    : S.of(context).abbreviation(travelWallet.abbreviation),
                // ? 'Добавить трату в ${travelWallet.abbreviation}'
                // : 'Вычесть из ${travelWallet.abbreviation}',
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ChoiceChip(
                        label: Text(S.of(context).expense),
                        selected: isAddition,
                        selectedColor: Theme.of(
                          context,
                        ).colorScheme.primaryContainer,
                        onSelected: (selected) {
                          if (selected) setDialogState(() => isAddition = true);
                        },
                      ),
                      const SizedBox(width: 12),
                      ChoiceChip(
                        label: Text(S.of(context).subtract),
                        selected: !isAddition,
                        selectedColor: Theme.of(
                          context,
                        ).colorScheme.primaryContainer,
                        onSelected: (selected) {
                          if (selected) {
                            setDialogState(() => isAddition = false);
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Поле ввода суммы
                  TextField(
                    controller: amountController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      labelText: S.of(context).amount,
                      hintText: S.of(context).enterTheAmount,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Выпадающий список категорий
                  DropdownButtonFormField<String>(
                    initialValue: selectedCategory,
                    decoration: InputDecoration(
                      labelText: S.of(context).category,
                      border: OutlineInputBorder(),
                    ),
                    items: categories(context).entries.map((entry) {
                      return DropdownMenuItem<String>(
                        value: entry.key,
                        child: Row(
                          children: [
                            Icon(entry.value.$2, size: 20),
                            const SizedBox(width: 10),
                            Text(entry.value.$1),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setDialogState(() => selectedCategory = value);
                      }
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(S.of(context).cancel),
                ),
                ElevatedButton(
                  onPressed: () {
                    final cleanText = amountController.text.replaceAll(
                      ',',
                      '.',
                    );
                    final enteredAmount = double.tryParse(cleanText) ?? 0.0;

                    if (enteredAmount > 0) {
                      final expensesBox = Hive.box<double>('expenses_box');
                      final abbr = travelWallet.abbreviation;

                      // 1. Запись категории (например: 'CNY_food')
                      final catKey = '${abbr}_$selectedCategory';
                      final currentCatExpenses = expensesBox.get(catKey) ?? 0.0;
                      expensesBox.put(
                        catKey,
                        currentCatExpenses +
                            (isAddition ? enteredAmount : -enteredAmount),
                      );

                      // 2. Запись общего тотала
                      final currentTotalExpenses = expensesBox.get(abbr) ?? 0.0;
                      expensesBox.put(
                        abbr,
                        currentTotalExpenses +
                            (isAddition ? enteredAmount : -enteredAmount),
                      );
                    }
                    Navigator.pop(context);
                  },
                  child: Text(S.of(context).apply),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
