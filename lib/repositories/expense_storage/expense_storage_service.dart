import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class ExpenseStorageService {
  static const String _boxName = 'expenses_box';

  Box<double> _getBox() => Hive.box<double>(_boxName);

  ValueListenable<Box<double>> get listenable => _getBox().listenable();

  /// Получить общие расходы по конкретной валюте
  double getTotalExpenses(String currencyCode) {
    return _getBox().get(currencyCode) ?? 0.0;
  }

  /// Получить расходы по конкретной категории
  double getCategoryExpenses(String currencyCode, String categoryKey) {
    final fullKey = '${currencyCode}_$categoryKey';
    return _getBox().get(fullKey) ?? 0.0;
  }

  /// Добавить или вычесть сумму для категории и общего тотала
  void updateExpenses({
    required String currencyCode,
    required String categoryKey,
    required double amount,
    required bool isAdding,
  }) {
    final box = _getBox();

    // Определяем финальное число: если вычитаем, делаем его отрицательным
    final finalAmount = isAdding ? amount : -amount;

    // 1. Обновляем категорию
    final fullCategoryKey = '${currencyCode}_$categoryKey';
    final currentCatExpenses = box.get(fullCategoryKey) ?? 0.0;
    box.put(fullCategoryKey, currentCatExpenses + finalAmount);

    // 2. Обновляем общий тотал валюты
    final currentTotalExpenses = box.get(currencyCode) ?? 0.0;
    box.put(currencyCode, currentTotalExpenses + finalAmount);
  }
}
