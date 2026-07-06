import 'package:flo_wallet/core/constants.dart';
import 'package:flo_wallet/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

void showBaseDialog(
  BuildContext context, {
  required String title,
  required String message,
  required List<Widget> actions,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        backgroundColor: context.colors.background,
        title: Text(
          title,
          style: AppTextStyle.titleStyle(
            size: 20,
            color: context.colors.primary,
          ),
        ),
        content: Text(message, style: AppTextStyle.titleStyle(size: 16)),
        actions: actions,
      );
    },
  );
}
