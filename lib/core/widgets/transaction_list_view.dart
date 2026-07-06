import 'package:flo_wallet/core/widgets/custom_circular_progress_indicator.dart';
import 'package:flo_wallet/core/widgets/transaction_item.dart';
import 'package:flo_wallet/features/transactions/domain/entities/transactions_entity.dart';
import 'package:flutter/material.dart';

class TransactionListView extends StatelessWidget {
  final String currentUId;
  final List<TransactionEntity> transactions;
  final ScrollController? scrollController;
  final bool isLoadingMore;
  const TransactionListView({
    super.key,
    required this.transactions,
    required this.currentUId,
    this.scrollController,
    this.isLoadingMore = false,
  });

  @override
  Widget build(BuildContext context) {
    final int totalItems = isLoadingMore
        ? transactions.length + 1
        : transactions.length;
    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.zero,
      itemCount: totalItems,
      itemBuilder: (context, index) {
        final bool isLastTransactions = index == totalItems - 1;
        if (index == transactions.length) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 18),
            child: Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CustomCircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
        }
        final TransactionEntity transaction = transactions[index];
        return Padding(
          padding: isLastTransactions
              ? EdgeInsets.only(bottom: 10)
              : EdgeInsets.zero,
          child: TransactionItem(
            isReceived: currentUId != transaction.senderId,
            transaction: transaction,
          ),
        );
      },
    );
  }
}
