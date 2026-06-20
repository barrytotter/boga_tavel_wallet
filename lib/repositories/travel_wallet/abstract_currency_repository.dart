import 'models/travel_wallet.dart';

abstract class AbstractCurrencyRepository {
  Future<List<TravelWallet>> getCurrencyRate();
}