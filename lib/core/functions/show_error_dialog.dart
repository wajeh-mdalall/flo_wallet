import 'package:flo_wallet/core/functions/show_base_dialog.dart';
import 'package:flo_wallet/core/widgets/buttons/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants.dart';

void showErrorDialog(
  BuildContext context,
  String? errMessage, {
  bool requiresSignIn = false,
  VoidCallback? onPressed,
}) {
  showBaseDialog(
    context,
    title: "Error",
    message: errMessage ?? "Unknown Error",
    actions: [
      CustomTextButton(
        onPressed: () {
          context.pop();
          if (onPressed != null) {
            onPressed();
          } else {
            if (requiresSignIn) context.go(AppConstants.kPhoneNumberView);
          }
        },
        title: requiresSignIn ? "Sign In Again" : "Try Again",
      ),
    ],
  );
}
