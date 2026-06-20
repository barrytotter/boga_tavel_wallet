  part of 'currency_list_bloc.dart';

  abstract class CurrencyListState extends Equatable{
    const CurrencyListState();

    @override
    List<Object?> get props => [];
  }

  class CurrencyListInitial extends CurrencyListState {
    const CurrencyListInitial();
  }
  class CurrencyListLoaded extends CurrencyListState {
    const CurrencyListLoaded(this.currencyRates);

    final List<TravelWallet> currencyRates;

    @override
    List<Object?> get props => [currencyRates];
  }
  class CurrencyListLoading extends CurrencyListState {
    const CurrencyListLoading();

    @override
    List<Object?> get props => [];
  }

  class CurrencyListError extends CurrencyListState {
    const CurrencyListError(this.exception);

    final Object? exception;

    @override
    List<Object?> get props => [exception];
  }