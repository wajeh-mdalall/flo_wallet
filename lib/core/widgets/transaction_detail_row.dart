import 'package:flo_wallet/core/constants.dart';
import 'package:flo_wallet/core/extensions/theme_extension.dart';
import 'package:flo_wallet/core/widgets/short_id_text.dart';
import 'package:flutter/material.dart';

class TransactionDetailRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isId;
  final bool withDivider;

  const TransactionDetailRow({
    required this.title,
    required this.value,
    this.isId = false,
    this.withDivider = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: ApptextStyle.titleStyle(size: 14, useAlpha: true),
            ),
            Flexible(
              child: isId
                  ? ShortIdText(id: value)
                  : Text(
                      value,
                      overflow: TextOverflow.ellipsis,
                      style: ApptextStyle.titleStyle(size: 14),
                    ),
            ),
          ],
        ),
        if (withDivider)
          Divider(
            height: 24,
            color: context.colors.secondary.withAlpha(60),
          ),
      ],
    );
  }
}
