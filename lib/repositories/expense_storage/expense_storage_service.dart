import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:travel_wallet/features/currency_single/models/expense_transaction.dart';

class ExpenseStorageService {
  static const String _boxName = 'expenses_box';
  static const String _txBoxName = 'transactions_box';

  Box<double> _getBox() => Hive.box<double>(_boxName);
  Box<ExpenseTransaction> _getTxBox() =>
      Hive.box<ExpenseTransaction>(_txBoxName);

  ValueListenable<Box<double>> get listenable => _getBox().listenable();
  ValueListenable<Box<ExpenseTransaction>> get txListenable =>
      _getTxBox().listenable();

  /// Получить общие расходы по конкретной валюте
  double getTotalExpenses(String currencyCode) {
    return _getBox().get(currencyCode) ?? 0.0;
  }

  /// Получить расходы по конкретной категории
  double getCategoryExpenses(String currencyCode, String categoryKey) {
    final fullKey = '${currencyCode}_$categoryKey';
    return _getBox().get(fullKey) ?? 0.0;
  }

  /// 1. МЕТОД ПОЛУЧЕНИЯ ТРАНЗАКЦИЙ (фильтруем по валюте и сортируем от свежих к старым)
  List<ExpenseTransaction> getTransactions(String currencyCode) {
    final allTxs = _getTxBox().values.toList();

    return allTxs.where((tx) => tx.id.startsWith('${currencyCode}_')).toList()
      ..sort((a, b) => b.dateTime.compareTo(a.dateTime));
  }

  /// 2. МЕТОД ГРУППИРОВКИ (разбивает плоский список на мапу по дням)
  Map<DateTime, List<ExpenseTransaction>> getGroupedTransactions(
    String currencyCode,
  ) {
    final transactions = getTransactions(
      currencyCode,
    ); // Вот тут он вызывает метод выше!
    final Map<DateTime, List<ExpenseTransaction>> grouped = {};

    for (final tx in transactions) {
      final dateOnly = DateTime(
        tx.dateTime.year,
        tx.dateTime.month,
        tx.dateTime.day,
      );

      if (grouped[dateOnly] == null) {
        grouped[dateOnly] = [];
      }
      grouped[dateOnly]!.add(tx);
    }

    return grouped;
  }

  /// Добавить или вычесть сумму для категории и общего тотала
  void updateExpenses({
    required String currencyCode,
    required String categoryKey,
    required double amount,
    required bool isAdding,
  }) {
    final box = _getBox();
    final txBox = _getTxBox();

    // Определяем финальное число: если вычитаем, делаем его отрицательным
    final finalAmount = isAdding ? amount : -amount;

    // 1. Обновляем категорию
    final fullCategoryKey = '${currencyCode}_$categoryKey';
    final currentCatExpenses = box.get(fullCategoryKey) ?? 0.0;
    box.put(fullCategoryKey, currentCatExpenses + finalAmount);

    // 2. Обновляем общий тотал валюты
    final currentTotalExpenses = box.get(currencyCode) ?? 0.0;
    box.put(currencyCode, currentTotalExpenses + finalAmount);

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final txKey = '${currencyCode}_$timestamp';

    final newTransaction = ExpenseTransaction(
      id: txKey,
      amount: amount,
      categoryKey: categoryKey,
      isAdding: isAdding,
      dateTime: DateTime.now(),
    );

    txBox.put(txKey, newTransaction);
  }
}

/// хелпер
// Map<DateTime, List<ExpenseTransaction>> getGroupedTransactions(
//   String currencyCode,
// ) {
//   final transactions = getTransactions(currencyCode);
//   final Map<DateTime, List<ExpenseTransaction>> grouped = {};

//   for (final tx in transactions) {
//     // Обнуляем часы, минуты и секунды, чтобы сравнивать ТОЛЬКО даты (день, месяц, год)
//     final dateOnly = DateTime(
//       tx.dateTime.year,
//       tx.dateTime.month,
//       tx.dateTime.day,
//     );

//     if (grouped[dateOnly] == null) {
//       grouped[dateOnly] = [];
//     }
//     grouped[dateOnly]!.add(tx);
//   }

//   return grouped;
// }
