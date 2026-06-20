import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import '../../../repositories/travel_wallet/models/travel_wallet.dart';

@RoutePage()
class BynScreen extends StatelessWidget {
  const BynScreen({
    super.key,
    required this.travelWallet,
  });

  final TravelWallet travelWallet;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(travelWallet.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              travelWallet.abbreviation,
              style: theme.textTheme.displayLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'Официальный курс',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              '${travelWallet.officialRate}',
              style: theme.textTheme.displaySmall,
            ),
          ],
        ),
      ),
    );
  }
}