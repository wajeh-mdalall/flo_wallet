import 'package:flutter/material.dart';

class AppThemeColors {
  final Color primary;
  final Color secondary;
  final Color background;

  AppThemeColors({
    this.primary = const Color(0xFF3C69C9),
    required this.secondary,
    required this.background,
  });

  factory AppThemeColors.dark() {
    return AppThemeColors(
      secondary: const Color(0xFFFFFFFF),
      background: const Color(0xFF292929),
    );
  }

  factory AppThemeColors.light() {
    return AppThemeColors(
      secondary: const Color(0xFF292929),
      background: const Color(0xFFFFFFFF),
    );
  }
}
