import 'package:flutter/material.dart';
import 'package:travel_wallet/features/currency_single/models/expense_category.dart';
import 'package:travel_wallet/features/currency_single/models/expense_transaction.dart';
import 'package:travel_wallet/features/currency_single/view/country_screen.dart';
import 'package:travel_wallet/generated/l10n.dart';
import 'package:travel_wallet/repositories/expense_storage/expense_storage_service.dart';
import '../../../repositories/travel_wallet/models/travel_wallet.dart';

final expenseStorage = ExpenseStorageService();

void showAddExpenseDialog({
  required BuildContext context,
  required TravelWallet travelWallet,
  ExpenseTransaction? transaction,
}) {
  final allCategories = CountryScreen.getExpenseCategories(context);
  ExpenseCategory selectedCategory = allCategories.first;
  final isEditing = transaction != null;
  bool isAdding = true;
  final currencyCode = travelWallet.abbreviation;
  final amountController = TextEditingController(
    text: isEditing ? transaction.amount.toStringAsFixed(2) : '',
  );

  String? amountErrorText;

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
                    errorText: amountErrorText,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Выпадающий список категорий
                DropdownButtonFormField<ExpenseCategory>(
                  initialValue: selectedCategory,
                  decoration: InputDecoration(
                    labelText: S.of(context).category,
                    border: const OutlineInputBorder(),
                  ),
                  items: allCategories.map((category) {
                    return DropdownMenuItem<ExpenseCategory>(
                      value: category,
                      child: Row(
                        children: [
                          Icon(category.icon, size: 20),
                          const SizedBox(width: 10),
                          Text(category.name),
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
                  final text = amountController.text.trim();
                  if (text.isEmpty) {
                    setDialogState(() {
                      amountErrorText = 'Введите сумму';
                    });
                    return;
                  }

                  final cleanText = amountController.text.replaceAll(',', '.');
                  final enteredAmount = double.tryParse(cleanText) ?? 0.0;

                  if (enteredAmount <= 0) {
                    setDialogState(() {
                      amountErrorText = 'Введите сумму больше нуля';
                    });
                    return;
                  }

                  if (isEditing) {
                    // --- РЕЖИМ РЕДАКТИРОВАНИЯ ---
                    expenseStorage.updateTransaction(
                      currencyCode: currencyCode,
                      oldTransaction: transaction,
                      newAmount: enteredAmount,
                      newCategoryKey: selectedCategory.key,
                    );
                  } else {
                    // --- РЕЖИМ СОЗДАНИЯ ---
                    expenseStorage.updateExpenses(
                      currencyCode: travelWallet.abbreviation,
                      categoryKey: selectedCategory.key,
                      amount: enteredAmount,
                      isAdding:
                          isAdding, // по умолчанию расход, либо бери из параметров
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
