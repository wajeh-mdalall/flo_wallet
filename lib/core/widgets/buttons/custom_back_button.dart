import '../../constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 16,
            color: AppColors.secondary,
          ),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            }
          },
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
