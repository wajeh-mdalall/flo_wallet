import 'package:flo_wallet/core/extensions/theme_extension.dart';

import 'package:flutter/material.dart';

void showCustomModalBottomSheet(BuildContext context, {required Widget body}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    backgroundColor: context.colors.background,
    builder: (context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 4,
            decoration: BoxDecoration(
              color: context.colors.secondary.withAlpha(60),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 32),
          body,
          const SizedBox(height: 20),
        ],
      ),
    ),
  );
}
