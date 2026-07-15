import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:travel_wallet/features/currency_list/widgets/widgets.dart';
import 'package:travel_wallet/generated/l10n.dart';
import 'package:travel_wallet/repositories/travel_wallet/travel_wallet.dart';
import 'package:travel_wallet/routes/routes.dart';

import '../bloc/currency_list_bloc.dart';
import '../widgets/total_expenses_card.dart';

@RoutePage()
class TravelWalletScreen extends StatefulWidget {
  const TravelWalletScreen({super.key, this.title = 'Travel Wallet'});

  final String title;

  @override
  State<TravelWalletScreen> createState() => _TravelWalletScreenState();
}

class _TravelWalletScreenState extends State<TravelWalletScreen> {
  late final CurrencyListBloc _currencyListBlock;

  @override
  void initState() {
    super.initState();
    _currencyListBlock = CurrencyListBloc(
      GetIt.I<AbstractCurrencyRepository>(),
    );
    _currencyListBlock.add(LoadCurrencyList());
  }

  @override
  void dispose() {
    _currencyListBlock.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.document_scanner_outlined),
            onPressed: () {
              context.router.push(const TalkerRouteRoute());
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
          _currencyListBlock.add(LoadCurrencyList(completer));
          return completer.future;
        },
        child: BlocBuilder<CurrencyListBloc, CurrencyListState>(
          bloc: _currencyListBlock,
          builder: (context, state) {
            if (state is CurrencyListLoaded) {
              return Column(
                children: [
                  TotalExpensesCard(wallets: state.currencyRates),
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: state.currencyRates.length,
                      separatorBuilder: (context, i) => const Divider(),
                      itemBuilder: (context, i) {
                        final travelWallet = state.currencyRates[i];
                        return CurrencyListTile(travelWallet: travelWallet);
                      },
                    ),
                  ),
                ],
              );
            }
            if (state is CurrencyListError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      S.of(context).currencyRatesFailed,
                      style: Theme.of(
                        context,
                      ).textTheme.labelSmall?.copyWith(color: Colors.red),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      child: Text(S.of(context).retry),
                      onPressed: () {
                        _currencyListBlock.add(LoadCurrencyList());
                      },
                    ),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
