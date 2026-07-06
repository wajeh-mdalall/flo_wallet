import 'package:flo_wallet/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final double? strokeWidth;
  const CustomCircularProgressIndicator({super.key, this.strokeWidth});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: context.colors.secondary,
        strokeWidth: strokeWidth,
      ),
    );
  }
}
