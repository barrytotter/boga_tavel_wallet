// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'travel_wallet.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TravelWalletAdapter extends TypeAdapter<TravelWallet> {
  @override
  final typeId = 1;

  @override
  TravelWallet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TravelWallet(
      name: fields[0] as String,
      abbreviation: fields[1] as String,
      officialRate: (fields[2] as num).toDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, TravelWallet obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.abbreviation)
      ..writeByte(2)
      ..write(obj.officialRate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TravelWalletAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TravelWallet _$TravelWalletFromJson(Map<String, dynamic> json) => TravelWallet(
  name: json['Cur_Name'] as String,
  abbreviation: json['Cur_Abbreviation'] as String,
  officialRate: (json['Cur_OfficialRate'] as num).toDouble(),
);

Map<String, dynamic> _$TravelWalletToJson(TravelWallet instance) =>
    <String, dynamic>{
      'Cur_Name': instance.name,
      'Cur_Abbreviation': instance.abbreviation,
      'Cur_OfficialRate': instance.officialRate,
    };
