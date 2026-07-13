import 'package:hive_ce/hive_ce.dart';
part 'expense_transaction.g.dart';

@HiveType(typeId: 2)
class ExpenseTransaction extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final String categoryKey;

  @HiveField(3)
  final bool isAdding;

  @HiveField(4)
  final DateTime dateTime;

  ExpenseTransaction({
    required this.id,
    required this.amount,
    required this.categoryKey,
    required this.isAdding,
    required this.dateTime,
  });
}
