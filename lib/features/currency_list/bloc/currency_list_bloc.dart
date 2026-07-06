import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:travel_wallet/repositories/travel_wallet/models/travel_wallet.dart';
import 'package:travel_wallet/repositories/travel_wallet/travel_wallet.dart';

part 'currency_list_event.dart';
part 'currency_list_state.dart';

class CurrencyListBloc extends Bloc<CurrencyListEvent, CurrencyListState> {
  CurrencyListBloc(this.currencyRepository) : super(CurrencyListInitial()) {
    on<LoadCurrencyList>((event, emit) async {
      try {
        if (state is! CurrencyListLoaded) {
          emit(CurrencyListLoading());
        }
        final currencyRates = await currencyRepository.getCurrencyRate();
        emit(CurrencyListLoaded(currencyRates));
      } catch (e, st) {
        emit(CurrencyListError(e));
        GetIt.I<Talker>().handle(e, st);
      } finally {
        event.completer?.complete();
      }
    });
  }
  final AbstractCurrencyRepository currencyRepository;

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
