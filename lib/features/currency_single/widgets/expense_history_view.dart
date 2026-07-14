import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_wallet/features/currency_single/view/country_screen.dart';
import 'package:travel_wallet/features/currency_single/widgets/add_expense_dialog.dart';
import 'package:travel_wallet/repositories/expense_storage/expense_storage_service.dart';

class ExpenseHistoryView extends StatelessWidget {
  final String currencyCode;
  final dynamic travelWallet;

  static final expenseStorage = ExpenseStorageService();

  const ExpenseHistoryView({
    super.key,
    required this.currencyCode,
    required this.travelWallet,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Слушаем изменения в коробке транзакций
    return ValueListenableBuilder(
      valueListenable: expenseStorage.txListenable,
      builder: (context, box, child) {
        // 2. Получаем сгруппированные данные
        final groupedTransactions = expenseStorage.getGroupedTransactions(
          currencyCode,
        );

        // Если трат еще нет — показываем красивую заглушку
        if (groupedTransactions.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Text(
                'Здесь пока пусто...\nДобавьте ваш первый расход! 💸',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
          );
        }

        final days = groupedTransactions.keys.toList();

        // 3. Строим список дней
        return ListView.builder(
          shrinkWrap: true, // Чтобы ListView не занимал бесконечную высоту
          physics:
              const NeverScrollableScrollPhysics(), // Скроллиться будет весь экран
          itemCount: days.length,
          itemBuilder: (context, index) {
            final day = days[index];
            final txsForDay = groupedTransactions[day]!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ЗАГОВОЛОК ДНЯ (например: "13 июля 2026")
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: Text(
                    _formatHeaderDate(day),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // СПИСОК ТРАТ ЗА ЭТОТ ДЕНЬ
                Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: txsForDay.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, txIndex) {
                      final tx = txsForDay[txIndex];

                      // Ищем инфу о категории (иконку, имя, цвет) из нашего списка
                      final categories = CountryScreen.getExpenseCategories(
                        context,
                      );
                      final category = categories.firstWhere(
                        (c) => c.key == tx.categoryKey,
                        orElse: () => categories.first,
                      );

                      return Dismissible(
                        key: Key(tx.id), // Уникальный ключ для Flutter
                        direction: DismissDirection
                            .endToStart, // Свайп только справа налево
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20.0),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          // Вызываем удаление в сервисе
                          expenseStorage.deleteTransaction(
                            currencyCode: currencyCode,
                            transaction: tx,
                          );

                          // Показываем быстрый Снэкбар внизу с кнопкой отмены (опционально)
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Операция "${category.name}" удалена',
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        child: ListTile(
                          onTap: () {
                            // ПО ТАПУ ОТКРЫВАЕМ ДИАЛОГ И ПЕРЕДАЕМ ТРАНЗАКЦИЮ
                            showAddExpenseDialog(
                              context: context,
                              travelWallet:
                                  travelWallet, // передай сюда свой travelWallet
                              transaction:
                                  tx, // <- Передаем транзакцию! Диалог поймет, что это редактирование
                            );
                          },
                          leading: CircleAvatar(
                            backgroundColor: category.color.withValues(
                              alpha: 0.2,
                            ),
                            child: Icon(
                              category.icon,
                              color: category.color,
                              size: 20,
                            ),
                          ),
                          title: Text(category.name),
                          subtitle: Text(
                            DateFormat('HH:mm').format(tx.dateTime),
                          ),
                          trailing: Text(
                            '${tx.isAdding ? '+' : '-'}${tx.amount.toStringAsFixed(2)} $currencyCode',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: tx.isAdding ? Colors.green : Colors.red,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
              ],
            );
          },
        );
      },
    );
  }

  // Хелпер для красивого вывода даты заголовка
  String _formatHeaderDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    if (date == today) return 'Сегодня';
    if (date == yesterday) return 'Вчера';

    return DateFormat('d MMMM yyyy').format(date);
  }
}
