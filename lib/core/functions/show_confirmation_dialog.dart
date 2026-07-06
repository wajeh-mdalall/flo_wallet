import 'package:flo_wallet/core/functions/show_base_dialog.dart';
import 'package:flo_wallet/core/widgets/buttons/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void showConfirmationDialog(
  BuildContext context,
  String message, {
  String confirmText = "OK",
  required VoidCallback onConfirm,
  VoidCallback? onCancel,
}) {
  showBaseDialog(
    context,
    title: "Confirm",
    message: message,
    actions: [
      CustomTextButton(
        onPressed: () {
          if (onCancel != null) {
            onCancel();
          } else {
            context.pop();
          }
        },
        title: "Cancel",
      ),
      CustomTextButton(
        onPressed: () {
          context.pop();
          onConfirm();
        },
        title: confirmText,
      ),
    ],
  );
}
