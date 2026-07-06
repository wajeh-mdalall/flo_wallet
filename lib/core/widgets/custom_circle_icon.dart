import 'package:flo_wallet/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class CustomCircleIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double radius;
  final double? size;
  const CustomCircleIcon({
    super.key,
    this.radius = 24,
    required this.icon,
    required this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: color,
      child: Icon(
        icon,
        color: context.colors.secondary,
        size: size ?? radius + 2,
      ),
    );
  }
}
