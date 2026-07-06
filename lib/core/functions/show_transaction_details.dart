import 'package:flo_wallet/core/constants.dart';
import 'package:flo_wallet/core/functions/show_custom_modal_bottom_sheet.dart';
import 'package:flo_wallet/core/helper/date_helper.dart';
import 'package:flo_wallet/core/helper/transaction_ui_helper.dart';
import 'package:flo_wallet/core/widgets/custom_card_details.dart';
import 'package:flo_wallet/core/widgets/custom_circle_icon.dart';
import 'package:flo_wallet/core/widgets/transaction_detail_row.dart';
import 'package:flo_wallet/features/transactions/domain/entities/transactions_entity.dart';
import 'package:flutter/material.dart';

void showTransactionDetails(
  BuildContext context, {
  required TransactionIconDesign iconDesign,
  required TransactionEntity transaction,
  required bool isReceived,
}) {
  showCustomModalBottomSheet(
    context,
    body: Column(
      children: [
        CustomCircleIcon(
          radius: 36,
          icon: iconDesign.icon,
          color: iconDesign.color,
        ),
        const SizedBox(height: 16),
        Text(
          isReceived ? "Money Received" : "Money Sent",
          style: AppTextStyle.titleStyle(size: 16, useAlpha: true),
        ),
        const SizedBox(height: 8),
        Text(
          "${isReceived ? '+' : '-'}\$${transaction.amount}",
          style: AppTextStyle.titleStyle(size: 32),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        CustomCardDetails(
          withPadding: true,
          items: [
            TransactionDetailRow(
              title: "Title",
              value: transaction.title.isEmpty
                  ? "Money Transfer"
                  : transaction.title,
            ),
            TransactionDetailRow(
              title: isReceived ? "SenderName" : "ReceiverName",
              value: isReceived
                  ? (transaction.senderName ?? "Unknown Sender")
                  : (transaction.receiverName ?? "Unknown Receiver"),
            ),
            TransactionDetailRow(
              title: "Date",
              value: DateHelper.formatDate(transaction.timestamp),
            ),
            TransactionDetailRow(
              title: "Transaction ID",
              value: transaction.id,
              isId: true,
              withDivider: false,
            ),
          ],
        ),
      ],
    ),
  );
}
