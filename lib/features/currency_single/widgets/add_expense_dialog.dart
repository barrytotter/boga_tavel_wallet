import 'package:flutter/material.dart';
import 'package:travel_wallet/features/currency_single/view/country_screen.dart';
import 'package:travel_wallet/generated/l10n.dart';
import 'package:travel_wallet/repositories/expense_storage/expense_storage_service.dart';
import '../../../repositories/travel_wallet/models/travel_wallet.dart';

final expenseStorage = ExpenseStorageService();

void showAddExpenseDialog({
  required BuildContext context,
  required TravelWallet travelWallet,
}) {
  final amountController = TextEditingController();
  String selectedCategory = CountryScreen.categories(context).keys.first;
  bool isAdding = true;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: Text(S.of(context).abbreviation(travelWallet.abbreviation)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChoiceChip(
                      label: Text(S.of(context).expense),
                      selected: isAdding,
                      selectedColor: Theme.of(
                        context,
                      ).colorScheme.primaryContainer,
                      onSelected: (selected) {
                        if (selected) setDialogState(() => isAdding = true);
                      },
                    ),
                    const SizedBox(width: 12),
                    ChoiceChip(
                      label: Text(S.of(context).subtract),
                      selected: !isAdding,
                      selectedColor: Theme.of(
                        context,
                      ).colorScheme.primaryContainer,
                      onSelected: (selected) {
                        if (selected) setDialogState(() => isAdding = false);
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
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Выпадающий список категорий
                DropdownButtonFormField<String>(
                  initialValue: selectedCategory,
                  decoration: InputDecoration(
                    labelText: S.of(context).category,
                    border: const OutlineInputBorder(),
                  ),
                  items: CountryScreen.categories(context).entries.map((entry) {
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
                onPressed: () {
                  amountController
                      .dispose(); // Чистим за собой контроллер при отмене
                  Navigator.pop(context);
                },
                child: Text(S.of(context).cancel),
              ),
              ElevatedButton(
                onPressed: () {
                  final cleanText = amountController.text.replaceAll(',', '.');
                  final enteredAmount = double.tryParse(cleanText) ?? 0.0;

                  if (enteredAmount > 0) {
                    expenseStorage.updateExpenses(
                      currencyCode: travelWallet.abbreviation,
                      categoryKey: selectedCategory,
                      amount: enteredAmount,
                      isAdding: isAdding,
                    );
                  }

                  amountController.dispose(); // Чистим
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
