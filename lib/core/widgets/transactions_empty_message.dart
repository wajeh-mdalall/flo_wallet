import 'package:flo_wallet/core/constants.dart';
import 'package:flutter/material.dart';

class TransactionsEmptyMessage extends StatelessWidget {
  const TransactionsEmptyMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          "You don't have any transactions yet",
          style: ApptextStyle.titleStyle(
            size: 22,
          ),
        ),
      ),
    );
  }
}
