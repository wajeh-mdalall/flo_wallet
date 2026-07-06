import 'package:flutter/material.dart';

extension ColorLevelExtension on Color {
  Color level(double factor) {
    return withValues(
      red: (r * factor).clamp(0.0, 1.0),
      green: (g * factor).clamp(0.0, 1.0),
      blue: (b * factor).clamp(0.0, 1.0),
    );
  }
}
