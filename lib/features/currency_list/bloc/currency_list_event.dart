  part of 'currency_list_bloc.dart';

  abstract class CurrencyListEvent extends Equatable {
    const CurrencyListEvent();
  }

  class LoadCurrencyList extends CurrencyListEvent {
        const LoadCurrencyList([this.completer]);
    final Completer? completer;

    @override
    List<Object?> get props => [completer];
  }