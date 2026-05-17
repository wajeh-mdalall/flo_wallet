import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants.dart';

void showErrorDialog(
  BuildContext context,
  String errMessage, {
  VoidCallback? onPressed,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: AppColors.background,
        actions: [
          TextButton(
            onPressed: () {
              if (onPressed != null) {
                onPressed();
              } else {
                context.pop();
              }
            },
            child: Text(
              "Try Again",
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ],
        content: Text(
          errMessage,
          style: TextStyle(
            color: AppColors.secondary,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      );
    },
  );
}
