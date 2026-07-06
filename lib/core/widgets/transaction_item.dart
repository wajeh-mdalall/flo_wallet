import 'package:flo_wallet/core/functions/show_transaction_details.dart';
import 'package:flo_wallet/core/helper/date_helper.dart';
import 'package:flo_wallet/core/helper/transaction_ui_helper.dart';
import 'package:flo_wallet/core/widgets/custom_circle_icon.dart';
import 'package:flo_wallet/features/transactions/domain/entities/transactions_entity.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class TransactionItem extends StatelessWidget {
  final TransactionEntity transaction;
  final bool isReceived;
  const TransactionItem({
    super.key,
    required this.transaction,
    required this.isReceived,
  });

  @override
  Widget build(BuildContext context) {
    final String operation = isReceived ? "+" : "-";
    final TransactionIconDesign iconDesign = TransactionUIHelper.getIconDesign(
      transaction.title,
    );
    return ListTile(
      onTap: () {
        showTransactionDetails(
          context,
          transaction: transaction,
          isReceived: isReceived,
          iconDesign: iconDesign,
        );
      },
      leading: CustomCircleIcon(icon: iconDesign.icon, color: iconDesign.color),
      title: Text(transaction.title, style: AppTextStyle.titleStyle(size: 16)),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Text(
          DateHelper.formatDate(transaction.timestamp),
          style: AppTextStyle.subtitleTextStyle(),
        ),
      ),
      trailing: Text(
        "$operation\$${transaction.amount}",
        style: AppTextStyle.titleStyle(size: 16),
      ),
    );
  }
}
