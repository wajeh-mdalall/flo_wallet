import 'package:flo_wallet/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class CustomRefreshIndicator extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final Future<void> Function() onRefresh;
  const CustomRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      elevation: isLoading ? 0 : 2,
      color: isLoading ? Colors.transparent : context.colors.secondary,
      backgroundColor: isLoading
          ? Colors.transparent
          : context.colors.background,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
