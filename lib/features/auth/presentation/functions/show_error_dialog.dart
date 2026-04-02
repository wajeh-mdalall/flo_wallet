import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants.dart';

void showErrorDialog(BuildContext context, String errMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
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
              color:AppColors.secondary ,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        );
      },
    );
  }