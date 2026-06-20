import 'package:equatable/equatable.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'travel_wallet.g.dart';

@HiveType(typeId: 1)

@JsonSerializable()
class TravelWallet extends Equatable {
  const TravelWallet({
    required this.name,
    required this.abbreviation,
    required this.officialRate,
  });
  
  @HiveField(0)
  @JsonKey(name: 'Cur_Name')
  final String name;

  @HiveField(1)
  @JsonKey(name: 'Cur_Abbreviation')
  final String abbreviation;

  @HiveField(2)
  @JsonKey(name: 'Cur_OfficialRate')
  final double officialRate;

  // Фабричный конструктор для создания объекта из JSON
  factory TravelWallet.fromJson(Map<String, dynamic> json) => 
      _$TravelWalletFromJson(json);

  // Метод для конвертации объекта обратно в JSON (если понадобится)
  Map<String, dynamic> toJson() => _$TravelWalletToJson(this);

  @override
  List<Object?> get props => [name, abbreviation, officialRate];
}