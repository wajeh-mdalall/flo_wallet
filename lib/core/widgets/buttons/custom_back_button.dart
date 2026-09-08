import 'package:flo_wallet/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBackButton extends StatelessWidget {
  final Color? color;
  final bool isLoading;
  const CustomBackButton({super.key, this.color, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: !isLoading ? context.colors.primary : Colors.grey,
          ),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 16,
            color: color ?? context.colors.secondary,
          ),
          onPressed: !isLoading
              ? () {
                  if (context.canPop()) {
                    context.pop();
                  }
                }
              : null,
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
