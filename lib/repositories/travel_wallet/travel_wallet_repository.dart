import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';
import './travel_wallet.dart';

class TravelWalletRepository implements AbstractCurrencyRepository {
  TravelWalletRepository({
    required this.dio, 
    required this.travelWalletBox,
    });
  final Dio dio;
  final Box<TravelWallet> travelWalletBox;
  

  @override
  Future<List<TravelWallet>> getCurrencyRate() async {
    try {
    final response = await dio.get(
       'https://api.nbrb.by/exrates/rates?periodicity=0'
    );

    final data = response.data as List<dynamic>;

    const neededCurrencies = {
    'USD', // доллар
    'EUR', // евро
    'VND', // донг
    'JPY', // иена
    'CNY', // юань
    'KZT', // тенге
  };
  
    final wallets = data
        .where((e) => neededCurrencies.contains(e['Cur_Abbreviation']))
        .map((e) => TravelWallet.fromJson(e as Map<String, dynamic>))
        .toList();

      wallets.sort(
        (a, b) => a.abbreviation.compareTo(b.abbreviation),
      );
    
      await travelWalletBox.putAll({
        for (final wallet in wallets)
      wallet.abbreviation: wallet,
      });
    return wallets;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      return travelWalletBox.values.toList();
    }
  }
}