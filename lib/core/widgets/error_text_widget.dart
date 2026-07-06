import 'package:flo_wallet/core/constants.dart';
import 'package:flutter/material.dart';

class ErrorTextWidget extends StatelessWidget {
  final String? errMessage;
  const ErrorTextWidget({super.key, this.errMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          errMessage ?? "Failed to access your information",
          textAlign: TextAlign.center,
          style: AppTextStyle.titleStyle(size: 18),
        ),
      ),
    );
  }
}
