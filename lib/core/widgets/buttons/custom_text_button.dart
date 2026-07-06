import 'package:flo_wallet/core/constants.dart';
import 'package:flo_wallet/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressed();
        Future.microtask(() {
          FocusManager.instance.primaryFocus?.unfocus();
        });
      },
      child: Text(
        title,
        style: AppTextStyle.titleStyle(size: 14, color: context.colors.primary),
      ),
    );
  }
}
