import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce/hive_ce.dart';
import '../../../repositories/travel_wallet/models/travel_wallet.dart';

@RoutePage()
class CountryScreen extends StatelessWidget {
  const CountryScreen({super.key, required this.travelWallet});

  final TravelWallet travelWallet;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(travelWallet.name)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              travelWallet.abbreviation,
              style: theme.textTheme.displayLarge,
            ),
            const SizedBox(height: 16),
            Text('Официальный курс', style: theme.textTheme.bodyMedium),
            const SizedBox(height: 8),
            Text(
              '${travelWallet.officialRate}',
              style: theme.textTheme.displaySmall,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddExpenseDialog(context),
        child: const Icon(Icons.add_card),
      ),
    );
  }

  void _showAddExpenseDialog(BuildContext context) {
    final amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Добавить трату в ${travelWallet.abbreviation}'),
          content: const TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Введите сумму'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () {
                final enteredAmount =
                    double.tryParse(amountController.text) ?? 0.0;

                if (enteredAmount > 0) {
                  final expensesBox = Hive.box<double>('expenses_box');

                  final currentExpenses =
                      expensesBox.get(travelWallet.abbreviation) ?? 0.0;

                  expensesBox.put(
                    travelWallet.abbreviation,
                    currentExpenses + enteredAmount,
                  );
                }
                Navigator.pop(context);
              },
              child: const Text('Добавить'),
            ),
          ],
        );
      },
    );
  }
}
