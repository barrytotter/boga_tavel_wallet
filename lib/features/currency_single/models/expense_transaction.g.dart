// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_transaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseTransactionAdapter extends TypeAdapter<ExpenseTransaction> {
  @override
  final typeId = 2;

  @override
  ExpenseTransaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenseTransaction(
      id: fields[0] as String,
      amount: (fields[1] as num).toDouble(),
      categoryKey: fields[2] as String,
      isAdding: fields[3] as bool,
      dateTime: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ExpenseTransaction obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.categoryKey)
      ..writeByte(3)
      ..write(obj.isAdding)
      ..writeByte(4)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseTransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
