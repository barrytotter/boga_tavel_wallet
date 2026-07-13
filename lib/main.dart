import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_settings.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:travel_wallet/features/currency_single/models/expense_transaction.dart';
import 'package:travel_wallet/firebase_options.dart';
import 'package:travel_wallet/repositories/travel_wallet/models/travel_wallet.dart';
import 'package:travel_wallet/repositories/travel_wallet/travel_wallet.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'travel_wallet_app.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton(talker);
  GetIt.I<Talker>().debug('Talker initialized');

  const String travelWalletBoxName = 'travel_wallet_box';

  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseTransactionAdapter());
  Hive.registerAdapter(TravelWalletAdapter());

  await Hive.openBox<double>('expenses_box');
  await Hive.openBox<ExpenseTransaction>('transactions_box');

  final travelWalletBox = await Hive.openBox<TravelWallet>(travelWalletBoxName);

  final firebaseApp = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  talker.info(firebaseApp.options.projectId, 'Firebase initialized');

  final dio = Dio();
  dio.interceptors.add(
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(printResponseData: false),
    ),
  );

  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      printStateFullData: false,
      printEventFullData: false,
    ),
  );

  GetIt.I.registerLazySingleton<AbstractCurrencyRepository>(
    () => TravelWalletRepository(dio: dio, travelWalletBox: travelWalletBox),
  );

  FlutterError.onError = (FlutterErrorDetails details) {
    GetIt.I<Talker>().handle(details.exception, details.stack);
  };
  runApp(const TravelWalletApp());
}
